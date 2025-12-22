const Product = require('../models/product.model')

/**
 * CREATE PRODUCT (PETANI)
 * POST /api/products
 */
exports.create = (req, res) => {
  const { name, price, stock, description } = req.body

  // Validasi input
  if (!name || !price || !stock) {
    return res.status(400).json({
      message: 'Data produk tidak lengkap'
    })
  }

  const data = {
    farmer_id: req.user.id, // dari JWT
    name,
    price,
    stock,
    description: description || ''
  }

  Product.create(data, (err) => {
    if (err) {
      return res.status(500).json({
        message: 'Gagal menambahkan produk'
      })
    }

    return res.json({
      message: 'Produk berhasil ditambahkan'
    })
  })
}

/**
 * GET ALL PRODUCTS
 * GET /api/products
 */
exports.getAll = (req, res) => {
  // Jika petani → hanya lihat produknya sendiri
  if (req.user.role === 'petani') {
    Product.findByFarmer(req.user.id, (err, rows) => {
      if (err) {
        return res.status(500).json({
          message: 'Gagal mengambil produk'
        })
      }
      return res.json(rows)
    })
  } 
  // Jika pembeli → lihat semua produk
  else {
    Product.findAll((err, rows) => {
      if (err) {
        return res.status(500).json({
          message: 'Gagal mengambil produk'
        })
      }
      return res.json(rows)
    })
  }
}
