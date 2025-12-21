import 'package:flutter/material.dart';
import 'add_produk_screen.dart';
import 'pesanan_masuk_screen.dart';

class DashboardPetani extends StatelessWidget {
  const DashboardPetani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Petani')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _menuCard(
              icon: Icons.add_box,
              title: 'Tambah Produk',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddProdukScreen()),
                );
              },
            ),
            _menuCard(
              icon: Icons.shopping_bag,
              title: 'Pesanan Masuk',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PesananMasukScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
