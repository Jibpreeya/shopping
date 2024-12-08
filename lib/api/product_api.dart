import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping/model/product.dart';
import 'package:shopping/widgets/Error_state.dart';

/// RECOMMENDED PRODUCTS ///
Future<List<Product>> fetchRecommendedProducts() async {
  final response = await http
      .get(Uri.parse('http://192.168.1.132:8080/recommended-products'));

  if (response.statusCode == 200) {
    // Parse the JSON data
    List<dynamic> data = json.decode(response.body);
    print('Response: ${response.body}');
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
    throw Exception('Failed to load products');
  }
}

/// LATEST PRODUCTS ///
Future<List<Product>> fetchLatestProducts() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.132:8080/products?limit=20'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> items = data['items']; // Access the list from the "items" key
    return items.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load latest products');
  }
}
