
const {ImgurClient}  = require("imgur");

const imgurClient = new ImgurClient({
    clientId: process.env.IMGUR_CLIENT_ID
});


module.exports = imgurClient;
