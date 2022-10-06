const express = require("express");
const router = express.Router();
const client = require("../start/database")();
const auth = require("../middleware/auth");
const asyncErrorHandler = require("../middleware/asyncErrorHandler");


router.get('/', auth, asyncErrorHandler(async(req, res)=>{
    
    const {email} = req.user;
    const getPurchaseQuery = "SELECT * FROM purchases_by_user WHERE email = ?"
    const getPurchase = await (await client).execute(getPurchaseQuery, [email]);
    if (!getPurchase.rowLength) return res.status(404).json({"msg":"purchase not found"});
    res.json({"purchase":getPurchase.rows, "msg":"success"});
}))

router.post('/', auth , asyncErrorHandler(async(req, res)=>{
 
    const {email} = req.user;
    if(!req.body.products) return res.status(400).send('request.body.products is required');
    const {products} = req.body;
    
    const addPurchaseQuery = "INSERT INTO purchases_by_user(email, id, created_at, products) VALUES(?, uuid(),toTimestamp(now()), ? )";
    await(await client).execute(addPurchaseQuery, [email, products], { prepare: true });

    res.json({"msg":"success"});
}))

module.exports = router;