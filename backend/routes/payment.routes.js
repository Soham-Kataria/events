const express = require('express')
const router = express.Router();
const {auth} = require('../middlewares/auth.middleware.js')
const {pay, getPayment} = require('../controller/payment.controller.js')

router.get('/',auth,getPayment)
router.post('/:orderId/payment/pay',auth,pay)



module.exports = router;