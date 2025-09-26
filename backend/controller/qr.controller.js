const QRCode = require("qrcode");
const Ticket = require("../models/ticket.model");
const ScanLog = require("../models/scanLog.model");

// Generate QR for a ticket
exports.generateTicketQR = async (req, res) => {
  try {
    const { ticketId } = req.params;
    const ticket = await Ticket.findById(ticketId).populate("eventId");
    if (!ticket) return res.status(404).json({ message: "Ticket not found" });

    const qrPayload = { ticketId: ticket._id, eventId: ticket.eventId._id };
    const qrCode = await QRCode.toDataURL(JSON.stringify(qrPayload));

    return res.json({ qrCode });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Failed to generate QR" });
  }
};

// Validate scanned QR + log
exports.validateTicketScan = async (req, res) => {
  try {
    const { ticketId, eventId } = req.body;
    const scannedBy = req.user._id;

    const ticket = await Ticket.findById(ticketId);
    if (!ticket) {
      await ScanLog.create({ ticketId, eventId, scannedBy, isValid: false });
      return res.status(404).json({ message: "Invalid ticket" });
    }

    if (ticket.eventId.toString() !== eventId) {
      await ScanLog.create({ ticketId, eventId, scannedBy, isValid: false });
      return res
        .status(400)
        .json({ message: "Ticket does not belong to this event" });
    }

    if (ticket.isUsed) {
      await ScanLog.create({ ticketId, eventId, scannedBy, isValid: false });
      return res.status(400).json({ message: "Ticket already used" });
    }

    ticket.isUsed = true;
    await ticket.save();

    await ScanLog.create({ ticketId, eventId, scannedBy, isValid: true });

    return res.json({ message: "Ticket valid", ticket });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Failed to validate scan" });
  }
};

// const QRCode = require("qrcode");
// const Ticket = require("../models/ticket.model");
// const Event = require("../models/event.model");
// const ScanLog = require("../models/scanLog.model.js");

// // 1. Generate QR for a ticket
// exports.generateTicketQR = async (req, res) => {
//   try {
//     const { ticketId } = req.params;

//     // Find ticket
//     const ticket = await Ticket.findById(ticketId).populate("eventId");
//     if (!ticket) return res.status(404).json({ message: "Ticket not found" });

//     // Encode ticket data in QR (only IDs, no sensitive info)
//     const qrPayload = {
//       ticketId: ticket._id,
//       eventId: ticket.eventId._id,
//     };

//     // Generate QR as Data URL
//     const qrCode = await QRCode.toDataURL(JSON.stringify(qrPayload));

//     return res.json({ qrCode });
//   } catch (err) {
//     console.error("QR generation error:", err);
//     res.status(500).json({ message: "Failed to generate QR" });
//   }
// };

// // 2. Validate scanned QR + log
// exports.validateTicketScan = async (req, res) => {
//   try {
//     const { ticketId, eventId } = req.body; // coming from scanned QR
//     const scannedBy = req.user._id; // assuming staff is authenticated

//     const ticket = await Ticket.findById(ticketId);

//     if (!ticket) {
//       await ScanLog.create({
//         ticketId,
//         eventId,
//         scannedBy,
//         isValid: false,
//       });
//       return res.status(404).json({ message: "Invalid ticket" });
//     }

//     // Check if ticket matches the event
//     if (ticket.eventId.toString() !== eventId) {
//       await ScanLog.create({
//         ticketId,
//         eventId,
//         scannedBy,
//         isValid: false,
//       });
//       return res
//         .status(400)
//         .json({ message: "Ticket does not belong to this event" });
//     }

//     // Check if already used
//     if (ticket.isUsed) {
//       await ScanLog.create({
//         ticketId,
//         eventId,
//         scannedBy,
//         isValid: false,
//       });
//       return res.status(400).json({ message: "Ticket already used" });
//     }

//     ticket.isUsed = true;
//     await ticket.save();

//     await ScanLog.create({
//       ticketId,
//       eventId,
//       scannedBy,
//       isValid: true,
//     });

//     return res.json({ message: "Ticket valid", ticket });
//   } catch (err) {
//     console.error("Validation error:", err);
//     res.status(500).json({ message: "Failed to validate scan" });
//   }
// };
