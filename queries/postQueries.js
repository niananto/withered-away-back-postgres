const client = require("./queries.js");
const regclient = require("./regQueries.js");
const bcrypt = require("bcrypt");
const res = require("express/lib/response");
const formatDate = require("../formatDate.js");

async function createUser(req, res) {
  // console.log("req", req.body);
	if (req.body.birthday) {
		req.body.birthday = formatDate.formatDate(req.body.birthday.toString());
	}
	try {
    await regclient.insertPeopleInfo(req.body);

    client.query(
        `SELECT ID FROM PEOPLE WHERE NAME LIKE $1 ORDER BY ID ASC`,
        [req.body.firstName + " " + req.body.lastName],
        async (err, result2) => {
          if (err) return console.error("error running query", err);

          const currentPeopleId = result2.rows[result2.rowCount - 1].id;
          await regclient.insertContactInfo(req.body, currentPeopleId);
          await regclient.insertMedicalInfo(req.body, currentPeopleId);
          await regclient.insertFavoriteInfo(req.body, currentPeopleId);
          await regclient.insertMonetoryInfo(req.body, currentPeopleId);

          const hashedPassword = await bcrypt.hash(req.body.password, 10);

          const q1 = `INSERT INTO USERS (ID, USERNAME, HASHED_PASSWORD, ROLE) VALUES ($1, $2, $3, $4)`;
          const params1 = [
              currentPeopleId,
              req.body.username,
              hashedPassword,
              "people",
          ];
          client.query(q1, params1, async (err, result) => {
            if (err) return console.error("error running query", q, err);
            console.log("user created");
            return res.status(201).send("User created");
          });
  }
    );
    

	} catch (e) {
		console.log(e);
		return res.status(500).send("Could Not Create User");
	}
}

async function insertIntoTable(req, res) {
    const tableName = req.params.tableName;
    req.body = formatDate.formatDates(req.body);
  
    let keys = [];
    let params = [];
    let placeholders = [];

    let i = 1;
    for (let [k, v] of Object.entries(req.body)) {
        keys.push(k);
        params.push(v);

        placeholders.push("$" + i);
        i++;
    }

    const attributes = keys.join(", ");
    const attrValues = placeholders.join(", ");
    const q =
        `INSERT INTO ${tableName} (` +
        attributes +
        `) VALUES (` +
        attrValues +
        `)`;

    client.query(q, params, async (err, result) => {
      if (err) return console.error("error running query", q, err);
      console.log("inserted into " + tableName);

      let searchList = [];
      for (let i = 0; i < keys.length; i++) {
          searchList.push(keys[i] + "=" + placeholders[i]);
      }
      const searchString = searchList.join(" AND ");

      const q1 = `SELECT * FROM ${tableName} WHERE ` + searchString;
      const params1 = params;
      client.query(q1, params1, async (err, result1) => {
        if (err) return console.error("error running query", q, err);
        
        let toBeReturned = result1.rows[result1.rowCount - 1];

        if (
            ["people", "staff", "doctor"].find(
                (userTable) => userTable == tableName.toLowerCase()
            ) != null
        ) {
            // const username = req.body.name.split(" ").join("").toLowerCase();
            var username = "";
            if (req.body.name) {
              username = req.body.name.replace(/\s/g, "").toLowerCase();
            } else {
              username = req.body.NAME.replace(/\s/g, "").toLowerCase();
            }
            const password = username + Math.floor(Math.random() * 90 + 10);
            const hashedPassword = await bcrypt.hash(password, 10);
            const currentId = toBeReturned.id;

            const q1 = `INSERT INTO USERS (ID, USERNAME, HASHED_PASSWORD, ROLE) VALUES ($1, $2, $3, $4)`;
            const params1 = [currentId, username, hashedPassword, tableName];
            await client.query(q1, params1);

            toBeReturned.username = username;
            toBeReturned.password = password;
        }

        return res.status(201).json(toBeReturned);
      });
    });
}

exports.createUser = createUser;
exports.insertIntoTable = insertIntoTable;
