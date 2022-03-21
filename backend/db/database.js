const mongoose = require("mongoose");

module.exports.connect = (DATABASE_URL) => {
  mongoose.connect(DATABASE_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

  const db = mongoose.connection;

  db.on("error", console.error.bind(console, "Connection Error:"));

  db.once("open", () => {
    console.log("🚀 MongoDB Connected");
  });
};
