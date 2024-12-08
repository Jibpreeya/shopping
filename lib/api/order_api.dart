import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/model/product.dart';
import 'package:http/http.dart' as http;

/// ORDER CHECKOUT  ///
Future<void> orderProducts(BuildContext context) async {
  final Uri url = Uri.parse('http://192.168.1.132:8080/orders/checkout');

  final Map<String, dynamic> body = {
    "products": [0],
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
    } else {
      throw Exception('Failed to order products');
    }
  } catch (_) {
    throw Exception('Failed to order products');
  }
}
