import 'dart:convert';
import '../models/product_model.dart';
import 'api_service.dart';
import 'auth_service.dart';

class ProductService {
  static Future<List<ProductModel>> getAllProducts() async {
    final res = await ApiService.get(
      '/products',
      AuthService.currentUser!.token,
    );

    final List data = jsonDecode(res.body);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
