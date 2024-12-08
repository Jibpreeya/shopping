// Dummy Cart Page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/api/order_api.dart';
import 'package:shopping/model/cart.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/screens/shopping_screen.dart';
import 'package:shopping/screens/success_screen.dart';
import 'package:shopping/widgets/AppBar.dart';
import 'package:shopping/widgets/Button.dart';

import 'package:flutter/material.dart';

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

class CartScreen extends StatelessWidget {
  final List<Product> cartItems = Cart.getCartItems(); // Example cart items

  void _navigateToShoppingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingScreen(),
      ),
    );
  }

  // Method to handle the order process and navigation
  void _orderProducts(BuildContext context) async {
    // Call the orderProducts function and check for success
    bool orderSuccess = await orderProducts(context);

    if (orderSuccess) {
      _showSnackBar(context, 'Order success!', Color.fromRGBO(67, 160, 71, 1));
      // After the Snackbar is shown, navigate to the Success screen
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
        );
      });
    } else {
      _showSnackBar(context, 'Something went wrong', Color(0xFFB71C1C));
    }
  }

  // Simulate the order process
  Future<bool> orderProducts(BuildContext context) async {
    // Simulate a delay to mimic an API call
    await Future.delayed(Duration(seconds: 2));

    // Simulating success
    return true; // Or you could return false for failure
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        onBackPressed: () {
          _navigateToShoppingPage(context);
        },
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Empty Cart',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 0),
                  Button(
                    onPressed: () => _navigateToShoppingPage(context),
                    label: 'Go to Shopping',
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Dismissible(
                        key: Key(product.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: const Color(0xFFB71C1C),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        onDismissed: (direction) {
                          // Implement logic to remove the item from cart
                          Cart.deleteProduct(product);
                        },
                        child: CartItemWidget(product: product),
                      );
                    },
                  ),
                ),
                // const Divider(height: 1),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8DEF8), // Set the background color here
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal:',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF65558F),
                              ),
                            ),
                            Text(
                              '${Cart.getSubtotal()}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF65558F),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Promotion discount:',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF65558F),
                              ),
                            ),
                            Text(
                              '-${Cart.getTotalDiscount()}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFFB71C1C),
                              ),
                            ),
                          ],
                        ),
                        // const Divider(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${Cart.getTotalPrice()}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF65558F),
                              ),
                            ),
                            Button(
                              onPressed: () {
                                _orderProducts(context);
                              },
                              label: 'Checkout',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Product product;

  const CartItemWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,##0.00');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      // color: Color(0xFFFEF7FF),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            const Icon(Icons.image, size: 40, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        color: Color(0xFF65558F),
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: formatter.format(product.price),
                          style: const TextStyle(
                            fontSize: 12, // Price font size
                            color: Color(0xFF65558F),
                          ),
                        ),
                        const TextSpan(
                          text: ' / unit',
                          style: TextStyle(
                            fontSize: 10, // Unit font size
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  Cart.deleteProduct(product);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0), // Equal padding
                  primary: const Color(0xFF65558F),
                  onPrimary: Colors.white,
                  minimumSize:
                      const Size(20, 20), // Ensures a consistent circular size
                ),
                child: const Text(
                  '-',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold), // Adjust text style
                ),
              ),
              Text(
                '${product.quantity}',
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Cart.addToCart(product);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0), // Equal padding
                  primary: const Color(0xFF65558F),
                  onPrimary: Colors.white,
                  minimumSize:
                      const Size(20, 20), // Ensures a consistent circular size
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold), // Adjust text style
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
