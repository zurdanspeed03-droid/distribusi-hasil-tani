const jwt = require('jsonwebtoken')
const { secret } = require('../config/jwt')

module.exports = (req, res, next) => {
  const authHeader = req.headers.authorization

  // Cek header
  if (!authHeader) {
    return res.status(401).json({
      message: 'Unauthorized'
    })
  }

  // Format: Bearer TOKEN
  const parts = authHeader.split(' ')
  if (parts.length !== 2) {
    return res.status(401).json({
      message: 'Unauthorized'
    })
  }

  const token = parts[1]

  jwt.verify(token, secret, (err, decoded) => {
    if (err) {
      return res.status(401).json({
        message: 'Invalid token'
      })
    }

    // Simpan user hasil decode JWT
    // decoded = { id, role, iat, exp }
    req.user = {
      id: decoded.id,
      role: decoded.role
    }

    next()
  })
}
