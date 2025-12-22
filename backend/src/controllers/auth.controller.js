const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const User = require('../models/user.model')
const { secret } = require('../config/jwt')

/**
 * REGISTER
 * POST /api/auth/register
 */
exports.register = (req, res) => {
  const { name, email, password, role } = req.body

  // Validasi input
  if (!name || !email || !password || !role) {
    return res.status(400).json({ message: 'Data tidak lengkap' })
  }

  // Validasi role
  const allowedRoles = ['petani', 'pembeli']
  if (!allowedRoles.includes(role)) {
    return res.status(400).json({ message: 'Role tidak valid' })
  }

  // Hash password
  const hashedPassword = bcrypt.hashSync(password, 8)

  User.create(
    {
      name,
      email,
      password: hashedPassword,
      role
    },
    (err) => {
      if (err) {
        // Email duplikat
        if (err.message && err.message.includes('UNIQUE')) {
          return res.status(400).json({ message: 'Email sudah terdaftar' })
        }
        return res.status(500).json({ message: 'Server error' })
      }

      return res.status(201).json({
        message: 'Register berhasil'
      })
    }
  )
}

/**
 * LOGIN
 * POST /api/auth/login
 */
exports.login = (req, res) => {
  const { email, password } = req.body

  if (!email || !password) {
    return res.status(400).json({ message: 'Email dan password wajib diisi' })
  }

  User.findByEmail(email, (err, user) => {
    if (err || !user) {
      return res.status(404).json({ message: 'User tidak ditemukan' })
    }

    const isPasswordValid = bcrypt.compareSync(password, user.password)
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Password salah' })
    }

    // Generate JWT
    const token = jwt.sign(
      {
        id: user.id,
        role: user.role
      },
      secret,
      { expiresIn: '1d' }
    )

    // RESPONSE FINAL (KONTRAK DENGAN FLUTTER)
    return res.json({
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
