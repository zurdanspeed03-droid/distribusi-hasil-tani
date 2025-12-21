const express = require('express')
const router = express.Router()
const paymentController = require('../controllers/payment.controller')
const auth = require('../middlewares/auth.middleware')
const role = require('../middlewares/role.middleware')

router.post(
  '/',
  auth,
  role('pembeli'),
  paymentController.pay
)

module.exports = router
