import 'package:flutter/material.dart';

class RiwayatPesananScreen extends StatelessWidget {
  const RiwayatPesananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pesanan')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Pesanan #001'),
            subtitle: Text('Selesai'),
          ),
        ],
      ),
    );
  }
}
