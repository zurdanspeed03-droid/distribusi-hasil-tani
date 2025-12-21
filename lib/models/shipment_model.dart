class ShipmentModel {
  final int id;
  final int orderId;
  final String status;
  final String? trackingNumber;

  ShipmentModel({
    required this.id,
    required this.orderId,
    required this.status,
    this.trackingNumber,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'],
      orderId: json['order_id'],
      status: json['status'],
      trackingNumber: json['tracking_number'],
    );
  }
}
