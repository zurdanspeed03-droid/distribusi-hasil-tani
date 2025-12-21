const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/user.model')
const { secret } = require('../config/jwt')

exports.register = (req, res) => {
  const { name, email, password, role } = req.body
  const hashedPassword = bcrypt.hashSync(password, 8)

  User.create(
    { name, email, password: hashedPassword, role },
    (err) => {
      if (err) return res.status(400).json({ message: 'Email sudah terdaftar' })
      res.json({ message: 'Register berhasil' })
    }
  )
}

exports.login = (req, res) => {
  const { email, password } = req.body

  User.findByEmail(email, (err, user) => {
    if (!user) return res.status(404).json({ message: 'User tidak ditemukan' })

    const valid = bcrypt.compareSync(password, user.password)
    if (!valid) return res.status(401).json({ message: 'Password salah' })

    const token = jwt.sign(
      { id: user.id, role: user.role },
      secret,
      { expiresIn: '1d' }
    )

    res.json({
      token,
      role: user.role
    })
  })
}
