module.exports = {
  secret: process.env.JWT_SECRET || 'distribusi_hasil_tani_secret',
  expiresIn: '1d'
}
