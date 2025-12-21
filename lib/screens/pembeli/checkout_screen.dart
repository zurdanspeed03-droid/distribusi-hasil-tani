import 'package:flutter/material.dart';
import 'pembayaran_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Total Pembayaran: Rp 24.000'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Bayar Sekarang'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PembayaranScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
