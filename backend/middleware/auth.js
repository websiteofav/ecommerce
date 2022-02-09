const jwt = require("jsonwebtoken");
const keys = require("../config/keys");

const Errors = require("../utils/common");

module.exports = (req, res, next) => {
  const token = req.header("Authorization");

  if (!token)
    res
      .status(401)
      .json({ Message: "Authorization Denied", Status: 401, Sucess: null });

  try {
    const decoded = jwt.verify(token, keys.jwtSecret);

    req.user = decoded.user;
    next();
  } catch (e) {
    res
      .status(401)
      .json({ Message: "Authorization Denied", Status: 401, Sucess: null });
  }
};
