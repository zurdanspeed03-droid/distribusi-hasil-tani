const express = require('express')
const router = express.Router()
const orderController = require('../controllers/order.controller')
const auth = require('../middlewares/auth.middleware')
const role = require('../middlewares/role.middleware')

// PEMBELI BUAT PESANAN
router.post(
  '/',
  auth,
  role('pembeli'),
  orderController.create
)

// PEMBELI LIHAT PESANAN SENDIRI
router.get(
  '/my',
  auth,
  role('pembeli'),
  orderController.getMyOrders
)

module.exports = router
