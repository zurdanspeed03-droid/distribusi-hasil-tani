import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onUpdateStatus;
  final VoidCallback? onRemove;

  const OrderCard({
    super.key,
    required this.order,
    this.onUpdateStatus,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        title: Text('Order #${order.id}'),
        subtitle: Text(
          'Status: ${order.status}\nTotal: Rp ${order.total}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onUpdateStatus != null)
              IconButton(
                icon: const Icon(Icons.update),
                onPressed: onUpdateStatus,
              ),
            if (onRemove != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}
