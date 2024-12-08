import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/api/product_api.dart';
import 'package:shopping/model/cart.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/widgets/Button.dart';
import 'package:shopping/widgets/Counter.dart';
import 'package:shopping/widgets/Error_state.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingScreen> {
  late Future<List<Product>> recommendedProducts;
  late Future<List<Product>> latestProducts;

  final Map<int, bool> _recommendedShowCounter = {};
  final Map<int, bool> _latestShowCounter = {};

  @override
  void initState() {
    super.initState();
    recommendedProducts = fetchRecommendedProducts();
    latestProducts = fetchLatestProducts();
  }

  // Adding product to cart //
  void _onAddToCartPressed(int productIndex, bool isRecommended) {
    setState(() {
      if (isRecommended) {
        recommendedProducts.then((products) {
          final product = products[productIndex]; // Accessing the product
          Cart.addToCart(product); // Add the product to cart
          _recommendedShowCounter[productIndex] = true; // Mark as added
        });
      } else {
        latestProducts.then((products) {
          final product = products[productIndex]; // Accessing the product
          Cart.addToCart(product); // Add the product to cart
          _latestShowCounter[productIndex] = true; // Mark as added
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Product added to cart!',
          style: TextStyle(
            fontSize: 8,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,##0.00');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Recommended Products ///
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Recommended Products',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 10, // Adjust the size here
                      ),
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: recommendedProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return ErrorStateWidget(
                    onRetry: () {
                      setState(() {
                        recommendedProducts = fetchRecommendedProducts();
                      });
                    },
                  );
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.only(right: 10),
                    shrinkWrap:
                        true, // Makes the ListView take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: products.length > 4 ? 4 : products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isCounterVisible =
                          _recommendedShowCounter[index] ?? false;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0), // Padding between items
                        leading: Container(
                          padding: const EdgeInsets.only(
                              left: 10), // Padding around the icon
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey, // Icon color
                            size: 40, // Icon size
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          children: [
                            // Title
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: Color(0xFF65558F),
                                fontSize: 10, // Title font size
                                fontWeight:
                                    FontWeight.bold, // Title font weight
                              ),
                            ),
                            const SizedBox(
                                height: 2), // Space between title and subtitle
                            // Subtitle
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
                        trailing: isCounterVisible
                            ? Container(
                                margin: const EdgeInsets.only(
                                    left: 8), // Margin for counter widget
                                child: const CounterWidget(),
                              )
                            : Button(
                                label: 'Add to Cart',
                                onPressed: () =>
                                    _onAddToCartPressed(index, true),
                              ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No products found.'));
                }
              },
            ),

            /// Latest Products Section ///
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Latest Products',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 10.0, // Adjust the size here
                      ),
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: latestProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return ErrorStateWidget(
                    onRetry: () {
                      setState(() {
                        latestProducts = fetchLatestProducts();
                      });
                    },
                  );
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.only(right: 10),
                    shrinkWrap:
                        true, // Makes the ListView take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: products.length > 6 ? 6 : products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isCounterVisible =
                          _latestShowCounter[index] ?? false;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0), // Padding between items
                        leading: Container(
                          padding: const EdgeInsets.only(
                              left: 10), // Padding around the icon
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey, // Icon color
                            size: 40, // Icon size
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          children: [
                            // Title
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: Color(0xFF65558F),
                                fontSize: 10, // Title font size
                                fontWeight:
                                    FontWeight.bold, // Title font weight
                              ),
                            ),
                            const SizedBox(
                                height: 2), // Space between title and subtitle
                            // Subtitle
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
                        trailing: isCounterVisible
                            ? Container(
                                margin: const EdgeInsets.only(
                                    left: 8), // Margin for counter widget
                                child: const CounterWidget(),
                              )
                            : Button(
                                label: 'Add to Cart',
                                onPressed: () =>
                                    _onAddToCartPressed(index, false),
                              ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No latest products found.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
