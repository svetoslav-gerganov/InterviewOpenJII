const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

// Basic health check endpoint
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// Main route
app.get("/", (req, res) => {
  res.send(
    "Hello from OpenJII! This is a simple Node.js application for the DevOps assessment task."
  );
});

// TODO: Consider implementing proper logging for production use
// For example, using Winston, Bunyan, or other logging libraries

// Start server
app.listen(port, () => {
  console.log(`OpenJII app listening at http://localhost:${port}`);
});
