import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'cart_screen.dart';

class DetailProdukScreen extends StatelessWidget {
  final ProductModel product;
  const DetailProdukScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Harga: Rp ${product.price}'),
            Text('Stok: ${product.stock}'),
            const Spacer(),
            ElevatedButton(
              child: const Text('Tambah ke Keranjang'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
