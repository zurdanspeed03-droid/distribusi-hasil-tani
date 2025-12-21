import 'dart:convert';
import '../models/order_model.dart';
import 'api_service.dart';

class OrderService {
  static Future<List<OrderModel>> getOrders(String token) async {
    final response = await ApiService.get(
      '/orders',
      token: token,
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map((e) => OrderModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<bool> createOrder(
    int total,
    String token,
  ) async {
    final response = await ApiService.post(
      '/orders',
      {'total': total},
      token: token,
    );
    return response.statusCode == 201;
  }
}
