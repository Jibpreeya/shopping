import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/api/product_api.dart';
import 'package:shopping/model/product.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingScreen> {
  late Future<List<Product>> recommendedProducts;
  late Future<List<Product>> latestProducts;

  @override
  void initState() {
    super.initState();
    recommendedProducts = fetchRecommendedProducts();
    latestProducts = fetchLatestProducts();
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
              padding: const EdgeInsets.fromLTRB(10, 30.0, 20.0, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Recommended Products',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: recommendedProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap:
                        true, // Makes the ListView take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: products.length > 4 ? 4 : products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Icon(Icons.new_releases),
                        title: Text(product.name),
                        subtitle: Text(
                          '${formatter.format(product.price)} /unit',
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Handle product tap
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No products found.'));
                }
              },
            ),

            // Latest Products Section
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20.0, 20.0, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Latest Products',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            FutureBuilder<List<Product>>(
              future: latestProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shrinkWrap:
                        true, // Makes the ListView take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: products.length > 6 ? 6 : products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Icon(Icons.new_releases),
                        title: Text(product.name),
                        subtitle: Text(
                          '${formatter.format(product.price)} /unit',
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Handle product tap
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No latest products found.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
