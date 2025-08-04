const express = require('express');
const app = express()
app.use(express.json());
const User = require('../models/user.model')
const bcrypt = require('bcryptjs')
const generateToken = require('../utils/generateToken');

exports.register = async (req,res, next)=>{
    try {
      if (!req.body) {
        return res.status(400).json({ error: 'Request body is missing' });
      }
        const {userName, email, contact, password, role} =  req.body;
        const userExists = await User.findOne({email});

        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }
        if (!password || password.length < 6) {
            return res.status(400).json({ message: "Password must be at least 6 characters" });
        }

        
        const hashedPass = await bcrypt.hash(password,15);
        const user = await User.create({userName, email, contact, password:hashedPass, role})

        res.status(201).json({
            _id:user._id,
            userName:user.userName,
            email:user.email,
            contact: user.contact,
            role: user.role,   
            token:generateToken(user._id)
        });
        
        
    } catch (error) {
        next(error)
    }
}


exports.login = async (req,res,next) =>{
    try {
        const { email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return  res.status(400).json({message:"User does not exists.Please regisrt first."});
        }

        const isMatch = await bcrypt.compare(password,user.password);

        if(!isMatch){
            return res.status(400).json({message:"Password does not match"})
        }

        res.status(200).json({
        _id: user._id,
        userName: user.userName,
        email: user.email,contact: user.contact,
        role: user.role,
        token: generateToken(user._id)
        });

    } catch (error) {
        next(error);       
    }
    
};


exports.updateUser= async (req,res,next) => {

  try {
    const user = await User.findById(req.params.id);

    if(!user){
      return res.status(400).json({message:"User not found"})
    }

    user.userName= req.body.userName || user.userName;
    user.email= req.body.email || user.email;
    user.contact= req.body.contact || user.contact;

    if(req.body.password){
      const hashedPass = await bcrypt.hash(req.body.password, 15);
      user.password = hashedPass;
    }

    await user.save();

    res.status(200).json({
      message:"User details are updated",
      userName:user.userName,
      email:user.email,
      contact:user.contact
    });

  } catch (error) {
    next(error)
  }
  
}


exports.deleteUser= async(req,res,next)=>{
  try {
    const user = await User.findById(req.params.id);
    const id = req.user.id;
    const role = req.user.role;

    if(!user){
      return res.status(400).json({message:"User not found"})
    }

    if (role === 'admin' || id === req.params.id ) {
      await User.deleteOne({_id: user._id})
      return res.status(200).json({
        userName:user.userName,
        message:"User is deleted"
      })
    }
    else{
        return res.status(403).json({
          message:"You are not authorized to delete this account"
        })
    }

    

  } catch (error) {
    next(error)
  }
};


exports.getUserProfile = async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id).select('-password');
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};

exports.getUsers = async (req,res,next) => {
  try {
    const user = await User.find({}).select('-password');
    res.status(200).json(user);

  } catch (error) {
    next(error);
  }
}