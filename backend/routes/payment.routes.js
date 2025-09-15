const express = require('express')
const router = express.Router();
const {auth} = require('../middlewares/auth.middleware.js')
const {pay, getPayment, getPaymentById, refundRequest} = require('../controller/payment.controller.js')

router.get('/',auth,getPayment)
router.get('/:id',auth,getPaymentById)
router.post('/:id/refund',auth,refundRequest)
router.post('/:orderId/payment/pay',auth,pay)



module.exports = router;