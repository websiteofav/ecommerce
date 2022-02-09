const mongoose = require("mongoose");

const keys = require("./keys");

const db = keys.mongoURI;

const connectDb = async () => {
  try {
    await mongoose.connect(db, {});

    console.log("MongoDB Connected");
  } catch (e) {
    console.log(e.message);
    process.exit(1);
  }
};

module.exports = connectDb;
