const client = require("./queries.js");

async function getSingleRow(req, res) {
  const id = req.params.id;
	const tableName = req.params.tableName;

  const q = `SELECT * FROM ${tableName} WHERE ID=$1`;
  const values = [id];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows[0]);
  });
}

async function getSingleRowCustom(req, res) {
  const attribute = req.params.attribute;
  const attrValue = req.params.attrValue;
  const tableName = req.params.tableName;

	const q = `SELECT * FROM ${tableName} WHERE ${attribute}=$1`;
	const values = [attrValue];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows[0]);
  });
}

async function getAllRow(req, res) {
  const tableName = req.params.tableName;

	const q = `SELECT * FROM ${tableName}`;
	const values = [];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows);
  });
}

async function joinTables(req, res) {
  const tableName1 = req.params.tableName1;
  const attribute1 = req.params.attribute1;
  const tableName2 = req.params.tableName2;
  const attribute2 = req.params.attribute2;

	const q = `SELECT * FROM ${tableName1} JOIN ${tableName2} 
                ON ${tableName1}.${attribute1}=${tableName2}.${attribute2}`;
	const values = [];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows);
  });
}

async function joinTablesReturnSingle(req, res) {
  const tableName1 = req.params.tableName1;
  const attribute1 = req.params.attribute1;
  const tableName2 = req.params.tableName2;
  const attribute2 = req.params.attribute2;
  const attrValue = req.params.attrValue;

	const q = `SELECT * FROM ${tableName1} JOIN ${tableName2} 
                ON ${tableName1}.${attribute1}=${tableName2}.${attribute2} WHERE ${attribute1}=$1`;
	const values = [attrValue];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows[0]);
  });
}

async function joinTablesReturnSingleCustom(req, res) {
  const tableName1 = req.params.tableName1;
  const attribute1 = req.params.attribute1;
  const tableName2 = req.params.tableName2;
  const attribute2 = req.params.attribute2;
  const attribute3 = req.params.attribute3;
  const attrValue = req.params.attrValue;

	const q = `SELECT * FROM ${tableName1} JOIN ${tableName2} 
                ON ${tableName1}.${attribute1}=${tableName2}.${attribute2} WHERE ${tableName2}.${attribute3}=$1`;
	const values = [attrValue];
  client.query(q, values, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    return res.status(200).json(result.rows[0]);
  });
}

exports.getSingleRow = getSingleRow;
exports.getSingleRowCustom = getSingleRowCustom;
exports.getAllRow = getAllRow;
exports.joinTables = joinTables;
exports.joinTablesReturnSingle = joinTablesReturnSingle;
exports.joinTablesReturnSingleCustom = joinTablesReturnSingleCustom;
