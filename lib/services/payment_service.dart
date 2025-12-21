import 'api_service.dart';

class PaymentService {
  static Future<bool> payOrder(
    int orderId,
    String method,
    String token,
  ) async {
    final response = await ApiService.post(
      '/payments',
      {
        'order_id': orderId,
        'method': method,
      },
      token: token,
    );
    return response.statusCode == 201;
  }
}
