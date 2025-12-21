import 'package:flutter/material.dart';
import 'riwayat_pesanan_screen.dart';

class StatusPesananScreen extends StatelessWidget {
  const StatusPesananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Status: Sedang Dikirim'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Lihat Riwayat'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RiwayatPesananScreen(),
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
