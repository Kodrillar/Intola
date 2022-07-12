const Joi = require("joi");

function validator(requestBody){
    const schema = Joi.object({
        email:Joi.string().max(255).required(),
        password:Joi.string().max(255).required()
    })

    return schema.validate(requestBody);
}

module.exports.validator = validator;