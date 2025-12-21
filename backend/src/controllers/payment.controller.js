const db = require('../config/db')

exports.pay = (req, res) => {
  const { order_id, method } = req.body

  db.run(
    `INSERT INTO payments (order_id, method, status)
     VALUES (?,?,?)`,
    [order_id, method, 'paid'],
    () => {
      db.run(
        `UPDATE orders SET status = ? WHERE id = ?`,
        ['paid', order_id]
      )
      res.json({ message: 'Pembayaran berhasil' })
    }
  )
}
