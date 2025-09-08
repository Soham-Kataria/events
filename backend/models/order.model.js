const mongoose = require('mongoose');

const orderSchema = mongoose.Schema({
    userId:{
        type : mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true
    },
    eventId:{
        type : mongoose.Schema.Types.ObjectId,
        ref: 'Event',
        required:true
    },
    ticketId:{
        type : mongoose.Schema.Types.ObjectId,
        ref : 'Ticket'
    },
    quantity:{
        type:Number,
        required:true,
        default:0
    },
    isScanned:{
        type: Boolean,
        default : false
    },
    qrCode: {
        type: String
    },
    status: {
        type: String,
        enum: ['Confirmed', 'Cancelled', 'Refunded',"Pending","Paid"],
        default: 'Pending'
    },
    totalPrice:{
        type: Number,
        required:true
    }

},{timestamps:true});

module.exports = mongoose.model('Order',orderSchema)