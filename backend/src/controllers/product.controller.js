const Product = require('../models/product.model')

exports.create = (req, res) => {
  const data = {
    farmer_id: req.user.id,
    name: req.body.name,
    price: req.body.price,
    stock: req.body.stock,
    description: req.body.description
  }

  Product.create(data, () => {
    res.json({ message: 'Produk berhasil ditambahkan' })
  })
}

exports.getAll = (req, res) => {
  Product.findAll((err, rows) => {
    res.json(rows)
  })
}
