import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  static Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];

      return products
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }
}