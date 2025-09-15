const mongoose = require("mongoose");
const paymentSchema = mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    orderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Order",
    },
    amount: {
      type: Number,
      required: true,
    },
    paymentStatus: {
      type: String,
      enum: ["pending", "success", "failed"],
      default: "pending",
    },
    gateWay: {
      type: String,
      enum: ["razerPay"],
      default: "razerPay",
    },
    refundRequest: {
      type: Boolean,
      default: false,
    },
    refund:{
        type:String,
        enum:["Refunded","Requested & Pending","Not requested yet"],
        default:"Not requested yet"
    }
    // paymentId:{
    //     type: String,
    //     required: true
    // }
  },
  { timestamps: true }
);

module.exports = mongoose.model("Payment", paymentSchema);
