

module.exports = function(err, req, res, next){

    res.status(500).json({"msg":"Oops! there's an internal server error, try again shortly..."});
    console.log(err);
}