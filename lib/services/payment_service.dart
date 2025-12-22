import 'api_service.dart';

class PaymentService {
  static Future<bool> payOrder({
    required int orderId,
    required String method,
  }) async {
    final response = await ApiService.post(
      '/payments',
      body: {
        'order_id': orderId,
        'method': method,
      },
    );

    return response.statusCode == 201;
  }
}
