const client = require("./queries.js");

async function insertPeopleInfo(reg) {
    const q = `INSERT INTO PEOPLE 
                (NAME, GENDER, BIRTHDAY, PHONE_NO)
                VALUES
                ($1, $2, $3, $4)`;
    const params = [
        reg.firstName + " " + reg.lastName,
        reg.gender,
        reg.birthday,
        reg.phoneNo,
    ];
    client.query(q, params, (err, result) => {
      if (err) return console.error("error running query", q, err);
      console.log("people info inserted");
    });
}

async function insertContactInfo(reg, currentPeopleId) {
  const q2 = `INSERT INTO CONTACT
      (NAME, PHONE_NO, ADDRESS)
      VALUES
      ($1, $2, $3)`;
  const params2 = [reg.contactName, reg.contactPhoneNo, reg.contactAddress];

  client.query(q2, params2, async (err, result2) => {
    if (err) return console.error("error running query", q2, err);
    console.log("contact info inserted");

    const q = `SELECT ID FROM CONTACT WHERE NAME LIKE $1`;
    client.query(q, [reg.contactName], async (err, result) => {
      if (err) return console.error("error running query", q, err);
      console.log("contact id selected");

      const currentContactId = result.rows[result.rowCount - 1].id;

      const q3 = `INSERT INTO CONNECTION
          (PEOPLE_ID, CONTACT_ID, RELATIONSHIP)
          VALUES
          ($1, $2, $3)`;
      const params3 = [
          currentPeopleId,
          currentContactId,
          reg.contactRelationship,
      ];

      client.query(q3, params3, async (err, result3) => {
        if (err) return console.error("error running query", q3, err);
        console.log("connection info inserted");
      });
    });
  });
}

async function insertMedicalInfo(reg, currentPeopleId) {
	for (let disease of Object.values(reg.diseases)) {
		if (disease.name.trim() === "") continue;
		let q1 = `CALL INSERT_INTO_DISEASE($1);`;
		let params1 = [disease.name];

    client.query(q1, params1, async (err, result1) => {
      if (err) return console.error("error running query", q1, err);
      console.log("disease inserted");
    });

    let q2 = `INSERT INTO SUFFER_FROM
            (PEOPLE_ID, DISEASE_ID) VALUES
            ($1, (SELECT ID FROM DISEASE WHERE NAME LIKE $2))`;
    let params2 = [currentPeopleId, disease.name];

    client.query(q2, params2, async (err, result2) => {
      if (err) return console.error("error running query", q2, err);
      console.log("suffer from inserted");
    });
	}

	for (let medicine of Object.values(reg.medicines)) {
		if (medicine.name.trim() === "") continue;
		let q3 = `CALL INSERT_INTO_MEDICINE($1);`;
		let params3 = [medicine.name];

    client.query(q3, params3, async (err, result3) => {
      if (err) return console.error("error running query", q3, err);
      console.log("medicine inserted");
    });
      
    let q4 = `INSERT INTO TAKES_MEDICINE
            (PEOPLE_ID, MEDICINE_ID, TIME) VALUES
            ($1, (SELECT ID FROM MEDICINE WHERE NAME LIKE $2), $3)`;
    let params4 = [currentPeopleId, medicine.name, medicine.time];

    client.query(q4, params4, async (err, result4) => {
      if (err) return console.error("error running query", q4, err);
      console.log("takes medicine inserted");
    });
  }

	const q5 = `INSERT INTO HEALTH_RECORD
        (PEOPLE_ID, HEIGHT, WEIGHT, BLOOD_GROUP, HEALTH_CONDITION) VALUES
        ($1, $2, $3, $4, $5)`;
	const params5 = [
		currentPeopleId,
		reg.height,
		reg.weight,
		reg.bloodGroup,
		reg.healthCondition,
	];

	client.query(q5, params5, async (err, result5) => {
    if (err) return console.error("error running query", q5, err);
    console.log("health record inserted");
  });

	for (let vaccine of Object.values(reg.vaccines)) {
		if (vaccine.name.trim() === "") continue;

		let q6 = `UPDATE HEALTH_RECORD SET VACCINE=(VACCINE || ' , ' || $1) WHERE PEOPLE_ID=$2`;
		let params6 = [vaccine.name, currentPeopleId];

		client.query(q6, params6, async (err, result6) => {
      if (err) return console.error("error running query", q6, err);
      console.log("vaccine inserted");
    });
	}

	for (let dissability of Object.values(reg.dissabilities)) {
		if (dissability.name.trim() === "") continue;

		let q7 = `UPDATE HEALTH_RECORD SET DISABILITY=(DISABILITY || ' , ' || $1) WHERE PEOPLE_ID=$2`;
		let params7 = [dissability.name, currentPeopleId];

		client.query(q7, params7, async (err, result7) => {
      if (err) return console.error("error running query", q7, err);
      console.log("dissability inserted");
    });
	}

	for (let allergy of Object.values(reg.allergies)) {
		if (allergy.name.trim() === "") continue;

		let q8 = `UPDATE HEALTH_RECORD SET ALLERGY=(ALLERGY || ' , ' || $1) WHERE PEOPLE_ID=$2`;
		let params8 = [allergy.name, currentPeopleId];

		client.query(q8, params8, async (err, result8) => {
      if (err) return console.error("error running query", q8, err);
      console.log("allergy inserted");
    });
	}

	return;
}

async function insertFavoriteInfo(reg, currentPeopleId) {
	for (let game of Object.values(reg.games)) {
		if (game.name.trim() === "") continue;

		let q1 = `CALL INSERT_INTO_GAME($1);`;
		let params1 = [game.name];

    client.query(q1, params1, async (err, result1) => {
      if (err) return console.error("error running query", q1, err);
      console.log("game inserted");
    });

		let q2 = `INSERT INTO GAME_FAVORITES
            (PEOPLE_ID, GAME_ID) VALUES
            ($1, (SELECT ID FROM GAME WHERE TITLE LIKE $2))`;
		let params2 = [currentPeopleId, game.name];

    client.query(q2, params2, async (err, result2) => {
      if (err) return console.error("error running query", q2, err);
      console.log("game favorite inserted");
    });
	}

	for (let song of Object.values(reg.songs)) {
		if (song.name.trim() === "") continue;

		let q1 = `CALL INSERT_INTO_SONG($1);`;
		let params1 = [song.name];

    client.query(q1, params1, async (err, result1) => {
      if (err) return console.error("error running query", q1, err);
      console.log("song inserted");
    });

		let q2 = `INSERT INTO SONG_FAVORITES
            (PEOPLE_ID, SONG_ID) VALUES
            ($1, (SELECT ID FROM SONG WHERE TITLE LIKE $2))`;
		let params2 = [currentPeopleId, song.name];

    client.query(q2, params2, async (err, result2) => {
      if (err) return console.error("error running query", q2, err);
      console.log("song favorite inserted");
    });
	}

	for (let movie of Object.values(reg.movies)) {
		if (movie.name.trim() === "") continue;

		let q1 = `CALL INSERT_INTO_MOVIE($1);`;
		let params1 = [movie.name];

    client.query(q1, params1, async (err, result1) => {
      if (err) return console.error("error running query", q1, err);
      console.log("movie inserted");
    });

		let q2 = `INSERT INTO MOVIE_FAVORITES
            (PEOPLE_ID, MOVIE_ID) VALUES
            ($1, (SELECT ID FROM MOVIE WHERE TITLE LIKE $2))`;
		let params2 = [currentPeopleId, movie.name];

    client.query(q2, params2, async (err, result2) => {
      if (err) return console.error("error running query", q2, err);
      console.log("movie favorite inserted");
    });
	}

	return;
}

async function insertMonetoryInfo(reg, currentPeopleId) {
    const q1 = `INSERT INTO ACCOUNT
        (BANK_ACCOUNT_NO, BANK_NAME, PEOPLE_ID, BALANCE) VALUES
        ($1, $2, $3, $4)`;
    const params1 = [
        reg.bankAccountNo,
        reg.bankName,
        currentPeopleId,
        reg.balance,
    ];

    client.query(q1, params1, async (err, result1) => {
      if (err) return console.error("error running query", q1, err);
      console.log("account inserted");
    });

    const q2 = `INSERT INTO SUBSCRIPTION
        (PEOPLE_ID, MEMBERSHIP_ID, STARTING_DATE) VALUES
        ($1, $2, CURRENT_DATE)`;
    const params2 = [currentPeopleId, reg.membershipId];

    client.query(q2, params2, async (err, result2) => {
      if (err) return console.error("error running query", q2, err);
      console.log("subscription inserted");
    });
}

exports.insertPeopleInfo = insertPeopleInfo;
exports.insertContactInfo = insertContactInfo;
exports.insertMedicalInfo = insertMedicalInfo;
exports.insertFavoriteInfo = insertFavoriteInfo;
exports.insertMonetoryInfo = insertMonetoryInfo;
