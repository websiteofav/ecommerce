const express = require("express");
const path = require("path");

const connectDB = require("./config/db");

const app = express();

connectDB();

app.use(
  express.json({
    extended: false,
  })
);
const PORT = process.env.PORT || 5000;

app.get("/", (req, res) => {
  res.send(`Working`);
});

app.use("/api/users", require("./routes/users"));

app.use("/api/products", require("./routes/mobile"));

app.use("/api/cart", require("./routes/cart"));

app.listen(PORT, () => console.log(`Server running on PORT ${PORT}`));
