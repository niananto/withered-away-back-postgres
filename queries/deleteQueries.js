const client = require("./queries.js");

async function deleteTableRow(req, res) {
  const tableName = req.params.tableName;
	const id = req.params.id;

	let q = "";
	if (tableName != "people" || tableName != "PEOPLE") {
		q = `DELETE FROM ${tableName} WHERE ID=$1`;
	} else {
		q = `CALL PEOPLE_DELETE($1);`;
	}
	const params = [id];

	client.query(q, params, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    console.log("deleted " + tableName);

    return res.status(200).send("Deleted " + tableName);
  });
}

async function deleteTableRowCustom(req, res) {
  const tableName = req.params.tableName;
  const attribute = req.params.attribute;
  const attrValue = req.params.attrValue;

	let q = "";
	if (tableName != "people" || tableName != "PEOPLE") {
		q = `DELETE FROM ${tableName} WHERE ${attribute}=$1`;
	} else {
		q = `CALL PEOPLE_DELETE($1);`;
	}
	const params = [attrValue];

	client.query(q, params, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    console.log("deleted " + tableName);

    return res.status(200).send("Deleted " + tableName);
  });
}

exports.deleteTableRow = deleteTableRow;
exports.deleteTableRowCustom = deleteTableRowCustom;
