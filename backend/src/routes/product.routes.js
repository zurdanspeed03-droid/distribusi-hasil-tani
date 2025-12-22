const express = require('express')
const router = express.Router()
const productController = require('../controllers/product.controller')
const auth = require('../middlewares/auth.middleware')
const role = require('../middlewares/role.middleware')

// Petani tambah produk
router.post(
  '/',
  auth,
  role('petani'),
  productController.create
)

router.get(
  '/',
  auth,
  productController.getAll
)

module.exports = router
