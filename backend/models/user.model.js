const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({

    userName:{
        type : String,
        required:true,
    },
    email:{
        type:String,
        required:true,
        unique:true
    },
    contact:{
        type:String,
        required:true,
        unique:true
    },
    password:{
        type: String,
        required:true,
        unique:true
    },
    role: {
        type: String,
        enum: ['user', 'admin', 'manager'],
        default: 'user'
    }

},{timestamps:true});

module.exports = mongoose.model('User', userSchema);