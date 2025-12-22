const Order = require('../models/order.model')
const db = require('../config/db')

exports.create = (req, res) => {
  const { items, total } = req.body

  if (!items || items.length === 0 || !total) {
    return res.status(400).json({ message: 'Data pesanan tidak lengkap' })
  }

  // TRANSACTION START
  db.serialize(() => {
    db.run('BEGIN TRANSACTION')

    Order.create(req.user.id, total, function (err) {
      if (err) {
        db.run('ROLLBACK')
        return res.status(500).json({ message: 'Gagal membuat pesanan' })
      }

      const orderId = this.lastID
      let errorOccured = false

      items.forEach(item => {
        if (!item.product_id || !item.quantity || !item.price) {
          errorOccured = true
          return
        }

        db.run(
          `INSERT INTO order_items (order_id, product_id, quantity, price)
           VALUES (?,?,?,?)`,
          [orderId, item.product_id, item.quantity, item.price],
          (err) => {
            if (err) {
              errorOccured = true
            }
          }
        )
      })

      if (errorOccured) {
        db.run('ROLLBACK')
        return res.status(500).json({ message: 'Gagal menyimpan item pesanan' })
      }

      db.run('COMMIT')
      return res.json({ message: 'Pesanan berhasil dibuat' })
    })
  })
}

exports.getMyOrders = (req, res) => {
  db.all(
    `SELECT * FROM orders WHERE buyer_id = ? ORDER BY created_at DESC`,
    [req.user.id],
    (err, rows) => {
      if (err) {
        return res.status(500).json({ message: 'Gagal mengambil data pesanan' })
      }
      res.json(rows)
    }
  )
}
