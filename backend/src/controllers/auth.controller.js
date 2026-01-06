const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/user.model')
const { secret } = require('../config/jwt')

/* ================= REGISTER ================= */
exports.register = (req, res) => {
  const { name, email, password, role } = req.body

  // Validasi input
  if (!name || !email || !password || !role) {
    return res.status(400).json({ message: 'Data tidak lengkap' })
  }

  const hashedPassword = bcrypt.hashSync(password, 8)

  User.create(
    { name, email, password: hashedPassword, role },
    (err) => {
      if (err) {
        return res.status(400).json({ message: 'Email sudah terdaftar' })
      }
      res.status(201).json({ message: 'Register berhasil' })
    }
  )
}

/* ================= LOGIN ================= */
exports.login = (req, res) => {
  const { email, password } = req.body

  if (!email || !password) {
    return res.status(400).json({ message: 'Email dan password wajib diisi' })
  }

  User.findByEmail(email, (err, user) => {
    if (err) {
      return res.status(500).json({ message: 'Server error' })
    }

    if (!user) {
      return res.status(404).json({ message: 'User tidak ditemukan' })
    }

    const valid = bcrypt.compareSync(password, user.password)
    if (!valid) {
      return res.status(401).json({ message: 'Password salah' })
    }

    const token = jwt.sign(
      { id: user.id, role: user.role },
      secret,
      { expiresIn: '1d' }
    )

    
    res.json({
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    })
  })
}
