import 'package:flutter/material.dart';

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300, // Set a fixed width for the entire AppBar
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 15),
          onPressed: onBackPressed,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start, // Align left
          children: [
            SizedBox(width: 0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12, // Adjust font size to make the text smaller
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
