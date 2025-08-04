const express = require('express')
const User = require('../models/user.model.js')
const Order = require('../models/order.model.js')
const Payment = require('../models/payment.model.js')

module.exports.pay = async (req,res,next) => {
    try {
        const userId = req.user._id
        const orderId = req.params.orderId
        console.log(req.params)
        const user = await User.findById(userId)
        if(!user){
            return res.status(400).json({message:"User Not found"})
        }
        const order = await Order.findById(orderId)

        if(!order){
            return res.status(400).json({message:"Order Not found"})
        }

        const existingPayment = await Payment.find({orderId:orderId})

        if(existingPayment){
            return res.status(400).json({message:"Payment already made"})
        }
        
        const payment = await Payment.create({userId,orderId,amount:order.totalPrice,paymentStatus:"success"});

        order.status = "Confirmed"
        await order.save()
        console.log(order)
        res.json(payment);

    } catch (error) {
        next(error)
    }
}



// if(payment.paymentStatus == "success"){
//             return res.status(400).json({message:"Payment already done"})
//         }