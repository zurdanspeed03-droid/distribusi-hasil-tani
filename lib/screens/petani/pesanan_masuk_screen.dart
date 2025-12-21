import 'package:flutter/material.dart';
import 'pengiriman_screen.dart';

class PesananMasukScreen extends StatelessWidget {
  const PesananMasukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Masuk')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Pesanan #001'),
              subtitle: const Text('Total: Rp 50.000'),
              trailing: ElevatedButton(
                child: const Text('Kirim'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PengirimanScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
