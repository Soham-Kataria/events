const mongoose = require('mongoose');
const User = require('./user.model.js')
const {Ticket,ticketSchema} = require('./ticket.model.js')

const eventSchema = mongoose.Schema({
    title:{
        type : String,
        required:true
    },
    description:{
        type : String,
        required:true
    },
    categories:{
        type : [String],
        required:true
    },
    eventStatus:{
        type: String,
        enum: ["upcoming","ongoing","ended"],
        default:"upcoming"
    },
    venue:{
        type : String,
        required:true
    },
    eventDate:{
        type : Date,
        required:true
    },
    endDate:{
        type : Date,
        required:true
    },
    createdBy:{
        type : mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    tickets:[ticketSchema],

},{timestamps:true});


module.exports = mongoose.model('Event', eventSchema);