const express = require('express')
const router = express.Router()
const shipmentController = require('../controllers/shipment.controller')
const auth = require('../middlewares/auth.middleware')
const role = require('../middlewares/role.middleware')

router.post(
  '/',
  auth,
  role('petani'),
  shipmentController.create
)

router.put(
  '/:id',
  auth,
  role('petani'),
  shipmentController.updateStatus
)

module.exports = router
