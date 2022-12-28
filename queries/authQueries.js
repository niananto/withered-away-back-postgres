const client = require("./queries.js");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

async function insertUser(req, res) {
  try {
    const role = req.body.role;
    const username = req.body.username;
    const password = await bcrypt.hash(req.body.password, 10);

    const q = `INSERT INTO USERS (ROLE, USERNAME, HASHED_PASSWORD) VALUES ($1, $2, $3)`;
    const params = [role, username, password];
    client.query(q, params, async (err, result) => {
      if (err) {
        console.log(err);
        return res.status(500).send();
      }

      const q1 = `SELECT * FROM USERS WHERE USERNAME=$1 AND ROLE=$2`;
      const params1 = [username, role];
      client.query(q1, params1, async (err, result1) => {
        if (err) {
          console.log(err);
          return res.status(500).send();
        }

        return res.status(201).json(result1.rows[0]);
      });
    });

	} catch(e) {
    console.log(e);
		res.status(500).send(e);
	}
}

async function getUsers(req, res) {
  const q = `SELECT * FROM USERS`;
  const params = [];
  client.query(q, params, async (err, result) => {
    if (err) {
      console.log(err);
      return res.status(500).send();
    }
    return res.status(200).json(result.rows);
  });
}

async function loginUser(req, res) {
  const q = `SELECT * FROM USERS`;
  const params = [];
  client.query(q, params, async (err, result) => {
    if (err) {
      console.log(err);
      return res.status(500).send();
    }

    const users = result.rows;
    const user = users.find(
      (user) =>
        user.role == req.body.role && // I can make this where the req does not have to have a role
        user.username == req.body.username
    );
    if (user == null) {
      console.log("user not found");
      return res.status(400).send("Cannot find user");
    }
    try {
      if (await bcrypt.compare(req.body.password, user.hashed_password)) {
        const payload = {
          role: user.role,
          username: user.username,
          password: user.hashed_password,
        };
        const accessToken = jwt.sign(
          payload,
          process.env.ACCESS_TOKEN_SECRET
        );
        if (user.id)
          return res.status(200).json({
            msg: "Success",
            id: user.id,
            accessToken: accessToken,
          });
        return res.status(200).json({ msg: "Success", accessToken: accessToken });

      } else {
        return res.status(405).json({ msg: "Not allowed" });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send();
    }
  });
}

exports.insertUser = insertUser;
exports.getUsers = getUsers;
exports.loginUser = loginUser;
