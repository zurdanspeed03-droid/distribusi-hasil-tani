const db = require('../config/db')

exports.create = (req, res) => {
  const { order_id, address } = req.body

  db.run(
    `INSERT INTO shipments (order_id, address, status)
     VALUES (?,?,?)`,
    [order_id, address, 'dikirim'],
    () => {
      db.run(
        `UPDATE orders SET status = ? WHERE id = ?`,
        ['dikirim', order_id]
      )
      res.json({ message: 'Pengiriman diproses' })
    }
  )
}

exports.updateStatus = (req, res) => {
  const { status } = req.body
  const { id } = req.params

  db.run(
    `UPDATE shipments SET status = ? WHERE id = ?`,
    [status, id],
    () => {
      res.json({ message: 'Status pengiriman diperbarui' })
    }
  )
}
