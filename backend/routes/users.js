const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { check, validationResult } = require("express-validator");

const User = require("../models/User");
const keys = require("../config/keys");
const auth = require("../middleware/auth");

const router = express.Router();

router.get("/", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select("-password");
    if (!user)
      return res.status(400).json({
        errors: { Message: `No User found`, Status: 400, Sucess: null },
      });
    res.json({ Success: user, Status: 200, Message: null });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ errors: { Message: `Server Error`, Status: 500, Sucess: null } });
  }
});

router.post(
  "/login",
  check(`email`, `Please include a valid email`).isEmail(),
  check(`password`, `Invalid Passsword`).not().isEmpty(),
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    try {
      const { email, password } = req.body;
      console.log(User);
      const user = await User.findOne({ email });

      if (!user) {
        return res.status(400).json({
          Message: `Invalid Credentials`,
          Status: 400,
          Success: null,
        });
      }

      const isMatch = await bcrypt.compare(password, user.password);

      if (!isMatch) {
        res.status(400).json({
          Message: "Invalid Credentials",
          Status: 400,
          Success: null,
        });
      }

      const payload = {
        user: {
          id: user.id,
        },
      };

      jwt.sign(
        payload,
        keys.jwtSecret,
        {
          expiresIn: 36000000,
        },
        (err, token) => {
          if (err) throw err;
          else
            res.json({ Success: { token: token }, Status: 200, Message: null });
        }
      );
    } catch (e) {
      console.log(e.message);
      // res.status(500).json({"Server Error", 'status': 400 });
      return res
        .status(500)
        .json({ errors: { msg: `Server Error`, status: 500 } });
    }
  }
);

router.post(
  "/register",
  check(`name`, "Name should not be empty"),
  check(`email`, `Please include a valid email`).isEmail(),
  check("password", "Invalid Passsword").isLength({ min: 6 }),
  check(`mobileNumber`, "Mobile Number not Valid").isMobilePhone(),

  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    try {
      const { name, email, password, mobileNumber } = req.body;
      let user = await User.findOne({ email });

      if (user) {
        return res
          .status(400)
          .json({ Message: `User already Exists`, Status: 400, Success: null });
      }

      user = new User({
        name,
        email,
        password,
        mobileNumber,
      });

      console.log(user);

      const salt = await bcrypt.genSalt(10);

      user.password = await bcrypt.hash(password, salt);
      await user.save();

      const payload = {
        user: {
          id: user.id,
        },
      };

      jwt.sign(
        payload,
        keys.jwtSecret,
        {
          expiresIn: 36000000,
        },
        (err, token) => {
          if (err) throw err;
          else
            res.json({ Success: { token: token }, Status: 200, Message: null });
        }
      );
    } catch (e) {
      console.log(e.message);
      return res.status(500).json({
        errors: { Message: `Server Error`, Status: 500, Message: null },
      });
    }
  }
);

module.exports = router;
