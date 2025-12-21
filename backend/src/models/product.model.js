const db = require('../config/db')

exports.create = (data, callback) => {
  db.run(
    `INSERT INTO products (farmer_id, name, price, stock, description)
     VALUES (?,?,?,?,?)`,
    [data.farmer_id, data.name, data.price, data.stock, data.description],
    callback
  )
}

exports.findAll = (callback) => {
  db.all(
    `SELECT * FROM products`,
    callback
  )
}
