const { Schema, model } = require("mongoose");

const UserSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },

  password: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now,
  },
  mobileNumber: {
    type: String,
    required: true,
  },
});

module.exports = model("user", UserSchema);
