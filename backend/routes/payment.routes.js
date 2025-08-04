const express = require('express')
const router = express.Router();
const {auth} = require('../middlewares/auth.middleware.js')
const {pay} = require('../controller/payment.controller.js')

router.post('/:orderId/payment/pay',auth,pay)

module.exports = router;