const express = require("express");
const router = express.Router();
const {
  generateTicketQR,
  validateTicketScan,
} = require("../controllers/qr.controller");
const { auth, hasRole } = require("../middlewares/auth.middleware");

router.get("/ticket/:ticketId/qr", auth, generateTicketQR);

router.post("/scan", auth, hasRole(["manager", "admin"]), validateTicketScan);

module.exports = router;

// const express = require("express");
// const router = express.Router();
// const {
//   generateTicketQR,
//   validateTicketScan,
// } = require("../controllers/qr.controller");
// const { authMiddleware } = require("../middlewares/auth.middleware");

// router.get("/ticket/:ticketId/qr", generateTicketQR);
// router.post("/scan", authMiddleware, validateTicketScan);

// module.exports = router;
