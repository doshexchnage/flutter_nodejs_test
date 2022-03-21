const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const bodyParser = require('body-parser');
const route = require('./routes/index');
const Database = require('./db/database');

const app = express();
dotenv.config();

app.use(express.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cors());
app.use(route);

// Database Connection
Database.connect(process.env.DATABASE_URL);

// Error Handling
app.use(function (err, _req, res, _next) {
  console.error(err);

  res.status(500);
  res.send({
    message: "Unfortunately a Technical Error Occurred",
  });
});

const PORT = process.env.PORT || 8000;

app.listen(PORT, () => {
  console.log("Doshex Weight Tracker Server");
  console.log(`🚀 Server Started on PORT ${PORT}`);
});