class ProductModel {
  final int id;
  final String name;
  final int price;
  final int stock;
  final String? description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      description: json['description'],
    );
  }
}
