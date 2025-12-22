import 'dart:convert';
import '../models/order_model.dart';
import 'api_service.dart';

class OrderService {
  static Future<bool> createOrder({
    required int total,
    required List<Map<String, dynamic>> items,
  }) async {
    final res = await ApiService.post(
      '/orders',
      body: {
        'total': total,
        'items': items,
      },
    );

    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      final order = OrderModel.fromJson(data);
      print(order);

      return true;
    }

    return false;
  }
}
