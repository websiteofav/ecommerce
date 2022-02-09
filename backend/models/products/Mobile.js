const { Schema, model } = require("mongoose");

const MobileSchema = new Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  namelower: {
    type: String,
    required: true,
  },
  price: {
    type: String,
    required: true,
  },
  realprice: {
    type: String,
    required: true,
  },
  discount: {
    type: String,
    required: true,
  },
  modelnumber: {
    type: String,
    required: true,
  },
  colors: [
    {
      type: String,
    },
  ],
  simtype: {
    type: String,
    required: true,
  },
  hybridsimslot: {
    type: Boolean,
    default: true,
  },

  category: {
    type: String,
    required: true,
  },
  subcategory: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    required: true,
  },

  date: {
    type: Date,
    default: Date.now,
  },

  displaysize: {
    type: String,
    required: true,
  },
  operatingsystem: {
    type: String,
    required: true,
  },
  processortype: {
    type: String,
    required: true,
  },
  clockspeed: {
    type: String,
    required: true,
  },
  internalstorage: {
    type: String,
    required: true,
  },
  ram: {
    type: String,
    required: true,
  },

  camera1: {
    type: String,
    default: "",
  },
  camera2: {
    type: String,
    default: "",
  },
  camera3: {
    type: String,
    default: "",
  },
  camera4: {
    type: String,
    default: "",
  },
  networktype: {
    type: String,
    required: true,
  },
  batterycapicity: {
    type: String,
    required: true,
  },
  quantity: {
    type: String,
    default: 5,
  },
});

MobileSchema.index({ name: "text" });

module.exports = model("mobile", MobileSchema);
