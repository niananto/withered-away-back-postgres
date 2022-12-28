require('dotenv').config({ path: '../.env' });
const { Client, Pool } = require('pg');

const conString = process.env.DB_URI || 'postgres://postgres:postgres@localhost:5432/postgres';
const client = new Client(conString);
client.connect(function(err) {
  if(err) {
    return console.error('could not connect to postgres', err);
  }
  return console.log('connected to postgres');
});

// const q = `SELECT * FROM ${tableName}`;
// const params = [];
// client.query(q, params, function(err, result) {
//   if(err) {
//     return console.error('error running query', err);
//   }
//   console.log(result.rows);
// });

// var tableName = 'people';
// var id = 1;
// const q = `SELECT * FROM ${tableName} WHERE ID=$1`;
//   const params = [id];
//   client.query(q, params, (err, result) => {
//     if (err) return console.error("error running query", q, err);
//     console.log(result.rows);
//   });

module.exports = client;
