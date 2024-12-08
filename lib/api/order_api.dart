import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/model/product.dart';
import 'package:http/http.dart' as http;

void _showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 10),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ),
  );
}

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

    if (response.statusCode == 200) {
      _showSnackBar(context, 'Order success!', Color.fromRGBO(67, 160, 71, 1));
    } else {
      _showSnackBar(context, 'Something went wrong', Color(0xFFB71C1C));
    }
  } catch (_) {
    _showSnackBar(context, 'Something went wrong', Color(0xFFB71C1C));
  }
}
