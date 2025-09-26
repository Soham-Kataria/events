const mongoose = require("mongoose");

const scanLogSchema = new mongoose.Schema({
  ticketId: { type: mongoose.Schema.Types.ObjectId, ref: "Ticket" },
  eventId: { type: mongoose.Schema.Types.ObjectId, ref: "Event" },
  scannedBy: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  isValid: { type: Boolean, default: false },
  scanTime: { type: Date, default: Date.now },
});

module.exports = mongoose.model("ScanLog", scanLogSchema);

// const mongoose = require("mongoose");
// const Ticket = require("./ticket.model");
// const User = require("./user.model");
// const Event = require("./event.model");

// const scanLog = mongoose.Schema({
//   ticketId: {
//     type: mongoose.Schema.Types.ObjectId,
//     ref: "Ticket",
//   },
//   eventId: {
//     type: mongoose.Schema.Types.ObjectId,
//     ref: "Event",
//   },
//   scannedBy: {
//     type: mongoose.Schema.Types.ObjectId,
//     ref: "User",
//   },
//   isValid: {
//     type: Boolean,
//     default: false,
//   },
//   scanTime: {
//     type: Date,
//     default: Date.now,
//   },
// });

// module.exports = mongoose.model("ScanLog", scanLog);
