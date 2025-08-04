const mongoose = require('mongoose');
const Event = require('./event.model.js');

const ticketSchema = new mongoose.Schema({
  // eventId: {
  //   type: mongoose.Schema.Types.ObjectId,
  //   ref: 'Event',
  //   required: true
  // },
  ticketPrice: {
    type: Number,
    // required: function () {
    //   return !this.isFree;
    // },
    min: [0, 'Ticket price cannot be negative']
  },
  totalTickets: {
    type: Number,
    // required: true,
    min: [1, 'Total tickets must be at least 1']
  },
  ticketsAvail: {
    type: Number,
    default: 0,
    min: [0, 'Available tickets cannot be negative']
  },
  ticketsSold: {
    type: Number,
    default: 0,
    min: [0, 'Tickets sold cannot be negative']
  },
  ticketType: {
    type: String,
    enum: ['VIP', 'General'],
    default: 'General'
  },
  isFree: {
    type: Boolean,
    default: false
  },
  bookingStartLine: {
    type: Date
  },
  bookingDeadLine: {
    type: Date
  },
  status: {
    type: String,
    enum: ['active', 'inactive', 'cancelled'],
    default: 'active'
  }
}, {
  timestamps: true // Adds createdAt and updatedAt fields
});

const Ticket = mongoose.model('Ticket', ticketSchema)

module.exports = {Ticket,ticketSchema};