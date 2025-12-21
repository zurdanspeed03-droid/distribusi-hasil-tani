const db = require('../config/db')

exports.create = (buyerId, total, callback) => {
  db.run(
    `INSERT INTO orders (buyer_id, status, total)
     VALUES (?,?,?)`,
    [buyerId, 'pending', total],
    callback
  )
}
