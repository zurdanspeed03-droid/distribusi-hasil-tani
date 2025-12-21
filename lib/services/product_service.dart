import 'dart:convert';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  static Future<List<ProductModel>> getProducts() async {
    final response = await ApiService.get('/products');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<bool> addProduct(
    ProductModel product,
    String token,
  ) async {
    final response = await ApiService.post(
      '/products',
      product.toJson(),
      token: token,
    );
    return response.statusCode == 201;
  }
}
