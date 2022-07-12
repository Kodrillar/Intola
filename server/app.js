require("dotenv").config()
const express = require("express");
const app = express();
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const fileupload = require("express-fileupload");
app.use(cors());
app.use(fileupload());
app.use(helmet());
app.use(morgan("tiny"));


require("./start/logger")();
require('./start/routes')(app);

const port =process.env.PORT || 4000;
const server = app.listen(port, ()=>{
    console.log("connected on PORT: " + port);
})

