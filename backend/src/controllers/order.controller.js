const Order = require('../models/order.model')
const db = require('../config/db')

exports.create = (req, res) => {
  const { items, total } = req.body

  Order.create(req.user.id, total, function () {
    const orderId = this.lastID

    items.forEach(item => {
      db.run(
        `INSERT INTO order_items (order_id, product_id, quantity, price)
         VALUES (?,?,?,?)`,
        [orderId, item.product_id, item.quantity, item.price]
      )
    })

    res.json({ message: 'Pesanan berhasil dibuat' })
  })
}

exports.getMyOrders = (req, res) => {
  db.all(
    `SELECT * FROM orders WHERE buyer_id = ?`,
    [req.user.id],
    (err, rows) => {
      res.json(rows)
    }
  )
}
