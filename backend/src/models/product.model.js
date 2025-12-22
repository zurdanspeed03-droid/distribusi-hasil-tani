const db = require('../config/db')

/**
 * CREATE PRODUCT
 */
exports.create = (data, callback) => {
  db.run(
    `INSERT INTO products (farmer_id, name, price, stock, description)
     VALUES (?,?,?,?,?)`,
    [
      data.farmer_id,
      data.name,
      data.price,
      data.stock,
      data.description
    ],
    callback
  )
}

/**
 * GET ALL PRODUCTS (PEMBELI)
 */
exports.findAll = (callback) => {
  db.all(
    `SELECT * FROM products`,
    callback
  )
}

/**
 * GET PRODUCTS BY FARMER (PETANI)
 */
exports.findByFarmer = (farmerId, callback) => {
  db.all(
    `SELECT * FROM products WHERE farmer_id = ?`,
    [farmerId],
    callback
  )
}
