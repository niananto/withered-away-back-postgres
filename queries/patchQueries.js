const client = require("./queries.js");
const formatDate = require("../formatDate.js");

async function patchTable(req, res) {
  const attrValue = req.params.attrValue;
  const attribute = req.params.attribute;
  const tableName = req.params.tableName;
  req.body = formatDate.formatDates(req.body);

	for (let [k, v] of Object.entries(req.body)) {
		const q = `UPDATE ${tableName} SET ${k}=$1 WHERE ${attribute}=$2`;
		const params = [v, attrValue];

		client.query(q, params, async (err, result) => {
      if (err) return console.error("error running query", q, err);
      console.log("updated " + tableName);

      return res.status(200).send("Updated " + tableName);
    });
	}
}

async function reqAppointment(req, res) {
  const peopleId = req.body.PEOPLE_ID;
	const doctorId = req.body.DOCTOR_ID;
	const appointedDate = formatDate.formatDate(
		req.body.APPOINTED_DATE.toString()
	);
	const reason = req.body.REASON;

	const q = `SELECT REQ_APPOINTMENT_AND_DEDUCE_FEE($1,$2,$3,$4);`;
	const params = [peopleId, doctorId, appointedDate, reason];

	client.query(q, params, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    console.log(result.rows[0].req_appointment_and_deduce_fee);

    return res.status(200).send(result.rows[0].req_appointment_and_deduce_fee);
  });
}

async function issueBook(req, res) {
  const peopleId = req.body.PEOPLE_ID;
	const bookId = req.body.BOOK_ID;
	const issueDate = formatDate.formatDate(req.body.ISSUE_DATE.toString());
	const returnDate = formatDate.formatDate(req.body.RETURN_DATE);

	const q = `SELECT ISSUE_BOOK_AND_DEDUCE_COST($1,$2,$3,$4);`;
	const params = [peopleId, bookId, issueDate, returnDate];

	client.query(q, params, async (err, result) => {
    if (err) return console.error("error running query", q, err);
    console.log(result.rows[0].issue_book_and_deduce_cost);

    return res.status(200).send(result.rows[0].issue_book_and_deduce_cost);
  });
}

exports.patchTable = patchTable;
exports.reqAppointment = reqAppointment;
exports.issueBook = issueBook;