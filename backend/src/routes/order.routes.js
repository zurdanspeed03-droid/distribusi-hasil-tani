const express = require('express')
const router = express.Router()
const orderController = require('../controllers/order.controller')
const auth = require('../middlewares/auth.middleware')
const role = require('../middlewares/role.middleware')

router.post(
  '/',
  auth,
  role('pembeli'),
  orderController.create
)

router.get(
  '/my',
  auth,
  role('pembeli'),
  orderController.getMyOrders
)

module.exports = router
