class ProductModel {
  final int id;
  final String name;
  final int price;
  final int stock;
  final int? petaniId;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.petaniId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      petaniId: json['petani_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'stock': stock,
        'petani_id': petaniId,
      };
}
