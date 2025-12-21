const db = require('../config/db')

exports.create = (data, callback) => {
  db.run(
    `INSERT INTO users (name, email, password, role)
     VALUES (?,?,?,?)`,
    [data.name, data.email, data.password, data.role],
    callback
  )
}

exports.findByEmail = (email, callback) => {
  db.get(
    `SELECT * FROM users WHERE email = ?`,
    [email],
    callback
  )
}
