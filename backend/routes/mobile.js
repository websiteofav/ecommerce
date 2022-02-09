const express = require("express");
const mongoose = require("mongoose");
const { check, validationResult } = require("express-validator");

const keys = require("../config/keys");
const auth = require("../middleware/auth");

const Mobile = require("../models/products/Mobile");

const router = express.Router();

router.get("/mobiles", auth, async (req, res) => {
  try {
    const mobiles = await Mobile.find().sort({ date: -1 });
    res.json({ Success: mobiles, Status: 200, Message: null });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ Message: `Server Error`, Status: 500, Sucess: null });
  }
});

router.post(
  "/mobiles",
  [
    auth,
    [
      check("name", "Name is required").not().isEmpty(),
      check("simtype", "Sim Type is required").not().isEmpty(),
      check("modelnumber", "Model Number is required").not().isEmpty(),
      check("category", "Category is Required").not().isEmpty(),
      check("subcategory", "Sub Category is Required").not().isEmpty(),
      check("image", "Image name required").not().isEmpty(),
      check("mobileNumber", "Mobile Number not Valid").isMobilePhone(),
      check("displaysize", "Display Size is Required").not().isEmpty(),
      check("operatingsystem", "Operating System required").not().isEmpty(),
      check("processortype", "Processor Type is required").not().isEmpty(),
      check("clockspeed", "Clock Speed is Required").not().isEmpty(),
      check("internalstorage", "Internal Storage is required").not().isEmpty(),
      check("ram", "RAM is required").not().isEmpty(),
      check("networktype", "Network Type is required").not().isEmpty(),
      check("batterycapicity", "Battery Capacity is required").not().isEmpty(),
      check("price", "Price is required").not().isEmpty(),
      check("realprice", "Real Price is required").not().isEmpty(),
      check("discount", "Discount is required").not().isEmpty(),
    ],
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      res.status(400).json({ errors: { errors: errors.array() } });
    }
    try {
      const {
        name,
        simtype,
        modelnumber,
        category,
        subcategory,
        image,
        mobileNumber,
        displaysize,
        operatingsystem,
        processortype,
        clockspeed,
        internalstorage,
        ram,
        networktype,
        batterycapicity,
        camera1,
        camera2,
        camera3,
        camera4,
        hybridsimslot,
        quantity,
        colors,
        price,
        realprice,
        discount,
      } = req.body;

      let mobile = await Mobile.findOne({ modelnumber });
      if (mobile)
        return res.status(400).json({
          Message: "Mobile already exists in the database",
          Status: 400,
          Success: null,
        });

      const namelower = name.toLowerCase();
      mobile = new Mobile({
        name,
        namelower,
        simtype,
        modelnumber,
        category,
        subcategory,
        image,
        mobileNumber,
        displaysize,
        operatingsystem,
        processortype,
        clockspeed,
        internalstorage,
        ram,
        networktype,
        batterycapicity,
        camera1,
        camera2,
        camera3,
        camera4,
        colors,
        quantity,
        hybridsimslot,
        price,
        realprice,
        discount,
      });

      await mobile.save();

      return res.json({ Success: mobile, Status: 200, Message: null });
    } catch (e) {
      console.log(e.message);
      return res.status(500).json({
        Message: `Server Error`,
        Status: 500,
        Sucess: null,
      });
    }
  }
);

router.get("/mobiles/:id", auth, async (req, res) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(req.params.id))
      return res.status(400).json({ errors: { msg: `No Data` } });

    const mobile = await Mobile.findById(req.params.id);

    res.json({ Success: mobile, Message: null, Status: 200 });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ Message: `Server Error`, Status: 500, Sucess: null });
  }
});

router.put("/mobiles/:id", auth, async (req, res) => {
  try {
    var mobileFields = {};

    mobileFields.colors = {};

    const {
      name,
      simtype,
      modelnumber,
      category,
      subcategory,
      image,
      mobileNumber,
      displaysize,
      operatingsystem,
      processortype,
      clockspeed,
      internalstorage,
      ram,
      networktype,
      batterycapicity,
      camera1,
      camera2,
      camera3,
      camera4,
      hybridsimslot,
      quantity,
      colors,
      price,
      realprice,
      discount,
    } = req.body;

    if (name) {
      mobileFields.name = name;
      mobileFields.namelower = name.toLowerCase();
    }
    if (simtype) mobileFields.simtype = simtype;
    if (modelnumber) mobileFields.modelnumber = modelnumber;
    if (category) mobileFields.category = category;
    if (subcategory) mobileFields.subcategory = subcategory;
    if (mobileNumber) mobileFields.mobileNumber = mobileNumber;
    if (displaysize) mobileFields.displaysize = displaysize;
    if (image) mobileFields.image = image;
    if (operatingsystem) mobileFields.operatingsystem = operatingsystem;
    if (processortype) mobileFields.processortype = processortype;
    if (clockspeed) mobileFields.clockspeed = clockspeed;
    if (internalstorage) mobileFields.internalstorage = internalstorage;
    if (ram) mobileFields.ram = ram;
    if (networktype) mobileFields.networktype = networktype;
    if (batterycapicity) mobileFields.batterycapicity = batterycapicity;
    if (camera1) mobileFields.camera1 = camera1;
    if (camera2) mobileFields.camera2 = camera2;
    if (camera3) mobileFields.camera3 = camera3;
    if (camera4) mobileFields.camera4 = camera4;
    if (hybridsimslot) mobileFields.hybridsimslot = hybridsimslot;
    if (quantity) mobileFields.quantity = quantity;
    if (colors) mobileFields.colors = colors;
    if (price) mobileFields.price = price;
    if (realprice) mobileFields.realprice = realprice;
    if (discount) mobileFields.discount = discount;

    let mobile = await Mobile.findById(req.params.id);

    if (!mobile)
      return res
        .status(400)
        .json({ Message: `No Data`, Success: null, Status: 400 });

    mobile = await Mobile.findOneAndUpdate(
      {
        _id: req.params.id,
      },
      { $set: mobileFields },
      { new: true }
    );

    return res.json({ Success: mobile, Status: 200, Message: null });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ Message: `Server Error`, Status: 500, Sucess: null });
  }
});

router.get("/mobiles/search/all", auth, async (req, res) => {
  try {
    const { query } = req.body;
    console.log(query);
    const mobiles = await Mobile.find({
      name: { $regex: query, $options: "i" },
    });

    if (mobiles.length == 0)
      return res
        .status(400)
        .json({ Message: `No Data`, Status: 400, Success: null });

    return res.send({ Success: mobiles, Status: 200, Message: null });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ Message: `Server Error`, Status: 500, Sucess: null });
  }
});

module.exports = router;
