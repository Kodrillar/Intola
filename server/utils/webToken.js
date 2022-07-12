const jwt  = require("jsonwebtoken");

module.exports.jsonwebtoken = function(email, fullname) {
   return jwt.sign({email, fullname}, process.env.JWT_KEY);
}