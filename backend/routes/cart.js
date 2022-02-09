const express = require("express");
const { check, validationResult } = require("express-validator");

const auth = require("../middleware/auth");

const Cart = require("../models/Cart");

const router = express.Router();

router.get("/", auth, async (req, res) => {
  try {
    const cart = await Cart.findOne({ user: req.user.id });
    if (!cart)
      return res
        .status(400)
        .json({ Message: `Cart is Empty`, Success: null, Status: 400 });

    return res.json({ Success: cart, Status: 200, Message: null });
  } catch (e) {
    console.log(e.message);
    return res
      .status(500)
      .json({ errors: { Message: `Server Error`, Status: 500, Sucess: null } });
  }
});

router.post("/", auth, async (req, res) => {
  try {
    let found = false;
    const { name, price, realprice, discount, quantity } = req.body;
    item = {
      name,
      price,
      realprice,
      discount,
      quantity,
    };
    let cart = await Cart.findOne({ user: req.user.id });

    if (!cart) {
      cart = new Cart({
        user: req.user.id,
      });
    } else {
      found = cart.products.some((el) => el.name === name);
    }
    if (found) {
      return res.status(400).json({
        Message: "Item already exists in the Cart",
        Status: 400,
        Success: null,
      });
    } else {
      cart.products.unshift(item);
      await cart.save();
      return res.json({ Message: null, Status: 200, Success: "Item Added" });
    }
  } catch (e) {
    console.log(e.message);
    return res.status(500).json({
      errors: { Message: `Server Error`, Status: 500, Sucess: null },
    });
  }
});

router.put(
  "/",
  [
    [
      check("name", "Name is required").not().isEmpty(),
      check("quantity", "Quantity is required").not().isEmpty(),
    ],
    auth,
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    try {
      let found = false;
      const { quantity, name } = req.body;

      let cart = await Cart.findOne({ user: req.user.id });

      if (!cart) {
        return res.status(400).json({
          Message: "Item not added to Cart",
          Status: 400,
          Success: null,
        });
      }
      // for (var i = 0; i< cart.products.length; i++){

      // }
      let item = cart.products.find((e) => e.name === name);
      if (!item)
        return res.status(400).json({
          Message: "Item not added to Cart",
          Status: 400,
          Success: null,
        });
      const itemIndex = cart.products.findIndex((e) => e.name === name);
      item.quantity = quantity;

      cart.products[itemIndex] = item;

      await cart.save();
      return res.json({ Message: null, Status: 200, Success: cart });
    } catch (e) {
      console.log(e.message);
      return res.status(500).json({
        errors: { Message: `Server Error`, Status: 500, Sucess: null },
      });
    }
  }
);

router.delete("/:id", auth, async (req, res) => {
  try {
    let cart = await Cart.findOne({ user: req.user.id });

    if (!cart) {
      return res.status(400).json({
        Message: "Item not added to Cart",
        Status: 400,
        Success: null,
      });
    }

    const itemIndex = cart.products.findIndex((e) => e.id == req.params.id);

    if (itemIndex < 0)
      return res.status(400).json({
        Message: "Item not added to Cart",
        Status: 400,
        Success: null,
      });
    else {
      cart.products.splice(itemIndex, 1);

      await cart.save();
      if (cart.products.length > 0)
        return res.json({ Message: null, Status: 200, Success: cart });
      else
        return res.json({
          Message: "Cart is Empty",
          Status: 400,
          Success: null,
        });
    }
  } catch (e) {
    console.log(e.message);
    return res.status(500).json({
      errors: { Message: `Server Error`, Status: 500, Sucess: null },
    });
  }
});

// Cart code check ..... map throught` cart

module.exports = router;
