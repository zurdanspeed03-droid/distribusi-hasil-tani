import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/order_service.dart';

class DetailProdukScreen extends StatefulWidget {
  final ProductModel product;
  const DetailProdukScreen({super.key, required this.product});

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  int qty = 1;
  bool loading = false;

  void orderNow() async {
    setState(() => loading = true);

    final success = await OrderService.createOrder(
      total: widget.product.price * qty,
      items: [
        {
          'product_id': widget.product.id,
          'quantity': qty,
          'price': widget.product.price,
        }
      ],
    );

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Pesanan berhasil' : 'Gagal membuat pesanan',
        ),
      ),
    );

    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga: Rp ${widget.product.price}'),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: qty > 1 ? () => setState(() => qty--) : null,
                ),
                Text(qty.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => qty++),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : orderNow,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Pesan Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
