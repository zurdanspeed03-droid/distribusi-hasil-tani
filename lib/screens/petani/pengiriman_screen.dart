import 'package:flutter/material.dart';

class PengirimanScreen extends StatelessWidget {
  const PengirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengiriman')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Alamat Pembeli'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Konfirmasi Kirim'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pesanan dikirim')),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
