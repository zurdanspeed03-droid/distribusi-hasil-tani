import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            title: Text('Beras Organik'),
            subtitle: Text('Qty: 2'),
            trailing: Text('Rp 24.000'),
          ),
          const Divider(),
          ElevatedButton(
            child: const Text('Checkout'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}
