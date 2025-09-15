// const express = require("express");
// const User = require("../models/user.model.js");
// const Order = require("../models/order.model.js");
// const Payment = require("../models/payment.model.js");

// exports.pay = async (req, res, next) => {
//   try {
//     const userId = req.user._id;
//     const orderId = req.params.orderId;
//     console.log(req.params);
//     const user = await User.findById(userId);
//     if (!user) {
//       return res.status(400).json({ message: "User Not found" });
//     }
//     const order = await Order.findById(orderId);

//     if (!order) {
//       return res.status(400).json({ message: "Order Not found" });
//     }

//     const existingPayment = await Payment.findOne({ orderId });

//     if (existingPayment) {
//       return res.status(400).json({ message: "Payment already made" });
//     }

//     const payment = await Payment.create({
//       userId,
//       orderId,
//       amount: order.totalPrice,
//       paymentStatus: "success",
//     });
//     order.status = "Paid";
//     await order.save();
//     res.json(payment);
//   } catch (error) {
//     next(error);
//   }
// };
// exports.getPayment = async (req, res, next) => {
//   try {
//     const user = req.user;
//     const payment = await Payment.find({ userId: user._id });
//     res.json(payment);
//   } catch (error) {
//     next(error);
//   }
// };

// exports.getPaymentById = async (req, res, next) => {
//   try {
//     const payment = await Payment.findById(req.params.id);
//     if (!payment) {
//       return res
//         .status(400)
//         .json({ message: "Paymeny not done or no payment found" });
//     }
//     res.json(payment);
//   } catch (error) {
//     next(error);
//   }
// };

// exports.refundRequest = async (req, res, next) => {
//   try {
//     const user = await User.findById(req.user.id);
//     const payment = await Payment.findById(req.params.id);
//     if (!user) {
//       return res.status(400).json({ message: "User Not found" });
//     }
//     if (!payment) {
//       return res
//         .status(400)
//         .json({ message: "Paymeny not done or no payment found" });
//     }
//     console.log(req.body);
//     const request = req.body;
//     payment.refundRequest = request.refundRequest;
//     payment.refund="Requested & Pending"
//     console.log(payment.refund)
//     await payment.save();
//     res.json(payment);
//   } catch (error) {
//     next(error);
//   }
// };
const express = require("express");
const User = require("../models/user.model.js");
const Order = require("../models/order.model.js");
const Payment = require("../models/payment.model.js");

// Helper function to check if the payment belongs to the user
const checkUserPayment = (user, payment) => {
  if (!payment.userId.equals(user._id)) {
    throw { status: 403, message: "Unauthorized access to this payment" };
  }
};

exports.pay = async (req, res, next) => {
  try {
    const userId = req.user._id;
    const orderId = req.params.orderId;

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const order = await Order.findById(orderId);
    if (!order) {
      return res.status(404).json({ message: "Order not found" });
    }

    const existingPayment = await Payment.findOne({ orderId });
    if (existingPayment) {
      return res.status(400).json({ message: "Payment already made" });
    }

    const payment = await Payment.create({
      userId,
      orderId,
      amount: order.totalPrice,
      paymentStatus: "success",
    });

    order.status = "Paid";
    await order.save();

    res.json(payment);
  } catch (error) {
    next(error);
  }
};

exports.getPayment = async (req, res, next) => {
  try {
    const user = req.user;
    const payment = await Payment.find({ userId: user._id });
    res.json(payment);
  } catch (error) {
    next(error);
  }
};

exports.getPaymentById = async (req, res, next) => {
  try {
    const user = req.user;
    const payment = await Payment.findById(req.params.id);

    if (!payment) {
      return res.status(404).json({ message: "Payment not found" });
    }

    checkUserPayment(user, payment);

    res.json(payment);
  } catch (error) {
    if (error.status) {
      return res.status(error.status).json({ message: error.message });
    }
    next(error);
  }
};

exports.refundRequest = async (req, res, next) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const payment = await Payment.findById(req.params.id);
    if (!payment) {
      return res.status(404).json({ message: "Payment not found" });
    }

    checkUserPayment(user, payment);

    if (payment.paymentStatus !== "success") {
      return res.status(400).json({ message: "Only successful payments can request a refund" });
    }

    const request = req.body;
    if (!request.refundRequest) {
      return res.status(400).json({ message: "Invalid refund request reason" });
    }

    payment.refundRequest = request.refundRequest;
    payment.refund = "Requested & Pending";

    await payment.save();

    res.json(payment);
  } catch (error) {
    if (error.status) {
      return res.status(error.status).json({ message: error.message });
    }
    next(error);
  }
};
