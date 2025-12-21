const db = require('../config/db')

exports.create = (orderId, address, callback) => {
  db.run(
    `INSERT INTO shipments (order_id, address, status)
     VALUES (?,?,?)`,
    [orderId, address, 'dikirim'],
    callback
  )
}

exports.updateStatus = (id, status, callback) => {
  db.run(
    `UPDATE shipments SET status = ? WHERE id = ?`,
    [status, id],
    callback
  )
}
