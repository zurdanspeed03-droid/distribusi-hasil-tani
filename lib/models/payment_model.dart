class PaymentModel {
  final int id;
  final int orderId;
  final String method;
  final String status;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.method,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      orderId: json['order_id'],
      method: json['method'],
      status: json['status'],
    );
  }
}
