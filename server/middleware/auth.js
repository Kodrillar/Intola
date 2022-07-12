const jwt = require("jsonwebtoken");

module.exports = function(req, res, next){

    let token = req.header("x-auth-token");
    
    if(!token) return res.status(401).send("Unauthorised, kindly login to continue!");
    try{
        const verifiedToken = jwt.verify(token, process.env.JWT_KEY);
        req.user = verifiedToken;
    
        next();
        
    } catch(err){
      res.status(400).send("Invalid jsonWebToken!");
    }
}