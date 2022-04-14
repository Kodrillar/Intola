const express = require("express");
const router = express.Router();
const client = require("../start/database")();
const auth = require("../middleware/auth");
const asyncErrorHandler = require("../middleware/asyncErrorHandler");


router.post('/', auth , asyncErrorHandler(async(req, res)=>{

    const {email,image,name} = req.body;
  
    const addPurchaseQuery = "INSERT INTO purchases_by_user(id, email, image, name, created_at, status) VALUES(uuid(), ?,?,?,toTimestamp(now()),'pending')";
    const addPurchase = await(await client).execute(addPurchaseQuery, [email, image, name]);
    res.json({"msg":"success"});
}))


router.get('/', auth, asyncErrorHandler(async(req, res)=>{
    
    const {email} = req.user;
    const getPurchaseQuery = "SELECT * FROM purchases_by_user WHERE email = ?"
    const getPurchase = await (await client).execute(getPurchaseQuery, [email]);
    if (!getPurchase.rowLength) return res.status(404).json({"msg":"purchase not found"});
    res.json({"purchase":getPurchase.rows, "msg":"success"});
}))
module.exports = router;