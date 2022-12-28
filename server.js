require("dotenv").config();

const express = require("express");
const res = require("express/lib/response");
const router = require("express-promise-router")();
const bcrypt = require("bcrypt");
const cors = require("cors");
const jwt = require("jsonwebtoken");

const app = express();
app.use(express.json());
app.use(cors());

const getQueries = require("./queries/getQueries.js");
const postQueries = require("./queries/postQueries.js");
const patchQueries = require("./queries/patchQueries.js");
const deleteQueries = require("./queries/deleteQueries.js");
const authQueries = require("./queries/authQueries.js");

const formatDate = require("./formatDate.js");

/// express ===================================

router.get("/api/:tableName/:id", getQueries.getSingleRow);
router.get("/api/:tableName/:attribute/:attrValue", getQueries.getSingleRowCustom);
router.get("/api/:tableName", getQueries.getAllRow);
router.get("/api/:tableName1/:attribute1/:tableName2/:attribute2", getQueries.joinTables);
router.get("/api/:tableName1/:attribute1/:tableName2/:attribute2/:attrValue", getQueries.joinTablesReturnSingle);
router.get("/api/:tableName1/:attribute1/:tableName2/:attribute2/:attribute3/:attrValue", getQueries.joinTablesReturnSingleCustom);

router.post("/api/reg", postQueries.createUser);
router.post("/api/:tableName", postQueries.insertIntoTable);

router.patch("/api/reqappointment", patchQueries.reqAppointment);
router.patch("/api/issuebook", patchQueries.issueBook);
router.patch("/api/:tableName/:attribute/:attrValue", patchQueries.patchTable);

router.delete("/api/:tableName/:id", deleteQueries.deleteTableRow);
router.delete("/api/:tableName/:attribute/:attrValue", deleteQueries.deleteTableRowCustom);

//// auth ==================================

router.get("/auth/users/all", authQueries.getUsers);

router.post("/auth/users/reg", authQueries.insertUser);

router.post("/auth/users/login", authQueries.loginUser);

router.get("/auth/check-admin", authenticateToken(["admin"]), (req, res) => {
	return res.status(200).json(req.msg);
});

router.get("/auth/check-people", authenticateToken(["people"]), (req, res) => {
	return res.status(200).json(req.msg);
});

router.get("/auth/check-doctor", authenticateToken(["doctor"]), (req, res) => {
	return res.status(200).json(req.msg);
});

router.get("/auth/check-staff", authenticateToken(["staff"]), (req, res) => {
	return res.status(200).json(req.msg);
});

function authenticateToken(roles) {
	return (req, res, next) => {
		try {
			const authHeader = req.headers["authorization"];
			const token = authHeader && authHeader.split(" ")[1];
			if (token == null) return res.sendStatus(401);

			jwt.verify(
				token,
				process.env.ACCESS_TOKEN_SECRET,
				(err, payload) => {
					if (err) return res.sendStatus(403);
					const roleMatch = roles.find(
						(role) => role == payload.role
					);
					if (roleMatch == null) return res.sendStatus(403);
					req.msg = "welcome " + payload.role;
					next();
				}
			);
		} catch (e) {
			console.log(e);
			res.status(500).send();
		}
	};
}

//// server ====================================

app.use(router);

const PORT = process.env.PORT || 8080;

app.listen(PORT, function () {
	console.log(`server started at port ${PORT}`);
});
