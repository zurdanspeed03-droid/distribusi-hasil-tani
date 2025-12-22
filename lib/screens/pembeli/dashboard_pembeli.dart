import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/product_service.dart';
import 'detail_produk_screen.dart';

class DashboardPembeli extends StatefulWidget {
  const DashboardPembeli({super.key});

  @override
  State<DashboardPembeli> createState() => _DashboardPembeliState();
}

class _DashboardPembeliState extends State<DashboardPembeli> {
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = ProductService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produk Hasil Tani')),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final p = data[i];
              return Card(
                child: ListTile(
                  title: Text(p.name),
                  subtitle: Text('Rp ${p.price}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailProdukScreen(product: p),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
