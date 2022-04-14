const express = require("express");
const router = express.Router();
const asyncErrorHandler = require("../middleware/asyncErrorHandler");
const client = require("../start/database")();
const {jsonwebtoken} = require("../utils/webToken")



router.post("/", asyncErrorHandler(async(req, res)=>{
    
    if(!req.body.email || !req.body.password) return res.status(400).send("Request body can't be empty");
    const {email, password} = req.body;

    const findUserQuery = "SELECT * FROM users_by_email WHERE email=?";
    let user = await(await client).execute(findUserQuery, [email]);
    
    if(!user.rowLength) return res.status(404).json({"userAlreadyExist":false, "msg":"User not found!"});
    if(user.first().password !== password) return res.status(400)
        .json({ 
            "wrongPassword":true,
            "userAlreadyExist":true,
            "msg":"Wrong/Invalid password"
        });
    
        const webToken = jsonwebtoken(email, user.first().fullname);

    res.header("x-auth-token", webToken)
    .json({
        "userAlreadyExist":true,
        "msg":"success",
        "token": webToken, 
        "wrongPassword":"false"
        });

    

}))

router.get("/:email", asyncErrorHandler(async(req, res)=>{
     //Instead of this, you can add "auth" middleware to this route and get current user from "req.user";
    const {email} = req.params

    const findUserQuery = "SELECT * FROM users_by_email WHERE email= ?";
    let user = await (await client).execute(findUserQuery, [email]); 
    if(!user.rowLength) return res.status(404)
        .json({
            "userAlreadyExist":false, 
            "msg":"User not found!"
        });
    res.json({
        "user": {
            "email":user.first().email, 
            "fullname":user.first().fullname,
        },
        "userAlreadyExist":true, 
        "msg":"success"
    })
}))


module.exports = router;
