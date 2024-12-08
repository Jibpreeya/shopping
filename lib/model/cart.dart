// cart_model.dart

import 'package:intl/intl.dart';

import 'product.dart'; // Assuming you have a Product class to represent your products

class Cart {
  static final List<Product> _cartItems = [];
  static final NumberFormat formatter = NumberFormat('#,##0.00');

  // Method to add product to the cart
  static void addToCart(Product product) {
    // Check if product is already in cart
    bool exists = false;
    for (var item in _cartItems) {
      if (item.id == product.id) {
        item.quantity++; // Increase the quantity if already exists in cart
        exists = true;
        break;
      }
    }
    if (!exists) {
      _cartItems.add(product);
    }
  }

  //  Method Remove product from the cart
  static void deleteProduct(Product product) {
    _cartItems.removeWhere((product) => product.id == product.id);
  }

  // Method to get all cart items
  static List<Product> getCartItems() {
    return _cartItems;
  }

  // Method to calculate sub total price without discount
  static String getSubtotal() {
    double subTotal = _cartItems.fold(
        0.0, (sum, product) => sum + (product.price * product.quantity));

    // Format subtotal with commas and two decimal places
    // final formatter = NumberFormat('#,##0.00');
    return formatter.format(subTotal);
  }

  // Method to calculate total price with discount
  static String getTotalPrice() {
    int total = 0;
    for (var product in _cartItems) {
      int productTotal = calculateProductPrice(product);
      total += productTotal;
    }
    return formatter.format(total);
  }

  // Method to calculate price for each product
  static int calculateProductPrice(Product product) {
    int totalPrice = 0;
    int pairs = product.quantity ~/ 2; // Number of pairs
    int remaining = product.quantity % 2; // Remaining single items

    // Calculate price for pairs
    int pairPrice = product.price * 2;
    int pairDiscount = (pairPrice * 0.05).toInt(); // 5% discount for each pair
    totalPrice += (pairPrice - pairDiscount) * pairs;

    // Add the remaining single item price
    totalPrice += product.price * remaining;

    return totalPrice;
  }

  // Method to calculate the discount for each product
  static int calculateProductDiscount(Product product) {
    int pairs = product.quantity ~/ 2; // Number of pairs
    int pairPrice = product.price * 2;
    int pairDiscount = (pairPrice * 0.05).toInt(); // 5% discount for each pair

    // Total discount for all pairs
    return pairDiscount * pairs;
  }

  // Method to calculate total discount for the cart
  static String getTotalDiscount() {
    int totalDiscount = 0;
    for (var product in _cartItems) {
      totalDiscount += calculateProductDiscount(product);
    }
    return formatter.format(totalDiscount);
  }
}
