import 'package:flutter/material.dart';
import 'detail_produk_screen.dart';
import '../../models/product_model.dart';

class DashboardPembeli extends StatelessWidget {
  const DashboardPembeli({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyProducts = [
      ProductModel(id: 1, name: 'Beras Organik', price: 12000, stock: 20),
      ProductModel(id: 2, name: 'Jagung Manis', price: 8000, stock: 15),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Produk Hasil Tani')),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text('Rp ${product.price}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailProdukScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
