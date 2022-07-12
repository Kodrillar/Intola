const express = require("express");
const error = require("../middleware/errorHandler");
const user = require("../routes/user");
const auth = require("../routes/auth");
const welcome = require("../routes/welcome");
const products = require("../routes/product");
const donations = require("../routes/donation");
const shipping = require("../routes/shipping");
const delivery = require("../routes/delivery");
const purchase = require("../routes/purchase");
module.exports = function(app){

app.use(express.json())
app.use("/api/uploads", express.static("uploads"));
app.use("/api/user/register", user);
app.use("/api/user/auth", auth );
app.use("/api/products", products);
app.use("/api/donations", donations);
app.use("/api/shipping", shipping);
app.use("/api/delivery", delivery);
app.use("/api/purchase", purchase);
app.use(welcome);
app.use(error)

}
