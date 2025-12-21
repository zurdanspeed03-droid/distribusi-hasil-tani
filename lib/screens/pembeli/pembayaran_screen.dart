import 'package:flutter/material.dart';
import 'status_pesanan_screen.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Metode: Transfer Manual'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Konfirmasi Pembayaran'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StatusPesananScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
