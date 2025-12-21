const db = require('../config/db')

exports.create = (orderId, method, callback) => {
  db.run(
    `INSERT INTO payments (order_id, method, status)
     VALUES (?,?,?)`,
    [orderId, method, 'paid'],
    callback
  )
}
