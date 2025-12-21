const express = require('express')
const cors = require('cors')

const authRoutes = require('./routes/auth.routes')
const productRoutes = require('./routes/product.routes')
const orderRoutes = require('./routes/order.routes')
const paymentRoutes = require('./routes/payment.routes')
const shipmentRoutes = require('./routes/shipment.routes')

const app = express()

app.use(cors())
app.use(express.json())

app.use('/api/auth', authRoutes)
app.use('/api/products', productRoutes)
app.use('/api/orders', orderRoutes)
app.use('/api/payments', paymentRoutes)
app.use('/api/shipments', shipmentRoutes)

module.exports = app
