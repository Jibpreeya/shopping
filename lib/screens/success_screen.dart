import 'package:flutter/material.dart';
import 'package:shopping/screens/shopping_screen.dart';
import 'package:shopping/widgets/AppBar.dart';
import 'package:shopping/widgets/Button.dart';

class SuccessScreen extends StatelessWidget {
  void _navigateToShoppingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingScreen(),
      ),
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Success!',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Thank you for shopping with us!',
              style: TextStyle(fontSize: 8),
            ),
            SizedBox(height: 2),
            Button(
              onPressed: () => _navigateToShoppingPage(context),
              label: 'Shop again',
            ),
          ],
        ),
      ),
    );
  }
}
