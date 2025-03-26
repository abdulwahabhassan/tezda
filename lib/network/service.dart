import 'package:dio/dio.dart';
import 'package:tezda/data/models/product.dart';

final dio = Dio();

class FakeStoreApiService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      Response response = await _dio.get("https://dummyjson.com/products");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data.containsKey("products")) {
          return Products.fromJson(data).products;
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
