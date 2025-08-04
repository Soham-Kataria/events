const express = require('express')
const router = express.Router();
const { setOrder, getOrders, getEventOrder, cancelOrder, updateOrder } = require("../controller/order.controller.js");
const { auth, hasRole } = require("../middlewares/auth.middleware.js");



router.post("/:eventId/:ticketId/booking",auth,setOrder);
router.get("/orders",auth,getOrders);
router.get("/:eventId/booking",auth,hasRole(['admin','manager']),getEventOrder)
router.delete("/:id/cancelOrder",auth,cancelOrder);
router.patch("/:id/updateOrder",auth,updateOrder)
module.exports = router;
