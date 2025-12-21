import 'package:flutter/material.dart';

class EditProdukScreen extends StatelessWidget {
  const EditProdukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Produk')),
      body: const Center(
        child: Text('Form edit produk'),
      ),
    );
  }
}
