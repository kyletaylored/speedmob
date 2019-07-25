// Import the Google Cloud client library
const { BigQuery } = require("@google-cloud/bigquery");
const bigquery = new BigQuery();

// Cloud vars
const bqDataset = process.env.SM_BQ_DATASET || null;
const bqTable = process.env.SM_BQ_TABLE || null;

/**
 * Inserts the JSON objects into my_dataset:my_table.
 * @param {String} dataset The BigQuery Dataset ID
 * @param {String} table The BigQuery Table ID
 * @param {Object} results The results object
 */
async function insertRows(datasetId, tableId, results) {
  // Insert data into a table
  await bigquery
    .dataset(datasetId)
    .table(tableId)
    .insert([results]);
}

/**
 * For adding a 0 pad to date values.
 * @param {Integer} n Number to add prefix 0 to.
 */
function pad(n) {
  return n < 10 ? "0" + n : n;
}

/**
 * HTTP function that supports CORS requests.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.logResults = (req, res) => {
  // Check for env
  if (!bqDataset || !bqTable) {
    console.log("No BigQuery vars defined.");
    return 0;
  }

  // Set CORS headers for preflight requests
  // Allows GETs from any origin with the Content-Type header
  // and caches preflight response for 3600s
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET");
  res.set("Access-Control-Allow-Methods", "POST");
  res.set("Access-Control-Allow-Headers", "Content-Type");
  res.set("Access-Control-Max-Age", "3600");

  // Check for JSON and POST
  if (req.get("content-type") === "application/json" && req.method === "POST") {
    insertRows(bqDataset, bqTable, req.body);
    console.log("Log speedtest", JSON.stringify(req.body));
    res.send("Success!");
  } else {
    // If not handling POST, redirect to Github.
    res.redirect("https://github.com/kyletaylored/speedmob");
  }
};
