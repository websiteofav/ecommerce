const { Schema, model } = require("mongoose");

const cartSchema = new Schema({
  user: {
    type: Schema.Types.ObjectId,
    ref: "users",
  },
  products: [
    {
      name: {
        type: String,
        required: true,
        // unique: true,
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
      quantity: {
        type: String,
        default: 1,
      },
    },
  ],
});

module.exports = model("cart", cartSchema);
