const express = require("express");
const router = express.Router();
const client = require("../start/database")();
const auth = require("../middleware/auth");
const asyncErrorHandler = require("../middleware/asyncErrorHandler");
const path = require("path");
const multer = require("multer");
const crypto = require("crypto");
const imgurClient = require("../utils/imgur_client");


let id = crypto.randomBytes(10).toString("hex");

function generateId(){
    id = crypto.randomBytes(10).toString("hex");

}

const storage  = multer.diskStorage({
  
    filename:(req, file, callback)=>{
        callback(null, req.user.email+id+".jpg")
    },
    destination: (req, file, callback)=>{
        callback(null, path.resolve(__dirname , "../upload/" ))
    },
})

const upload = multer({
    storage:storage
    
})

router.post('/', auth, asyncErrorHandler(async(req, res)=>{
   
    const {email} = req.user

    const {weight, price,description,location,contact} = req.body;

    if(!weight || !price || !description || !location || !contact ) return res.status(400).json({"msg":"request body can't be empty"});

    const addDeliveryQuery = "INSERT INTO delivery_by_user(id, email, image, weight, price, description, location, contact) VALUES(now(), ?,?,?,?,?,?,?)";
    const addDelivery = await(await client).execute(addDeliveryQuery, [email, "image", weight, price, description,location, contact]);
    res.json({"msg":"success"});
}));

router.get('/', auth, asyncErrorHandler(async(req, res)=>{

    const {email} = req.user;

    const getDeliveryQuery = "SELECT * FROM delivery_by_user";
    const getDelivery = await(await client).execute(getDeliveryQuery);
    if(!getDelivery.rowLength) return res.status(404).json({"msg":"Delivery not found"});
    res.send(getDelivery.rows);

}));

// upload.single("image"),

router.patch("/", auth,  asyncErrorHandler(async(req, res)=>{
    
    generateId();
    const {email} = req.user;

    const getDeliveryQuery = "SELECT * FROM delivery_by_user WHERE email = ?" ;
    const getDelivery = await(await client).execute(getDeliveryQuery, [email]);
    if(!getDelivery.rowLength) return res.status(404).json({"msg":"Delivery not found"});
    const deliveryId = getDelivery.first().id;

    const uploadImage =  await imgurClient.upload({
        image: req.files.image.data,
        type: "stream"
    });

    const imagePath = uploadImage.data.link;

    const updatetDeliveryQuery = "UPDATE delivery_by_user SET image= ? WHERE email = ? and id = ?";
    const updatetDelivery = await(await client).execute(updatetDeliveryQuery,[imagePath, email, deliveryId ]);
    
    res.send({"msg":"success"});
   

}))

  
module.exports = router;


