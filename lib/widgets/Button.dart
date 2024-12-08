import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const Button({
    Key? key,
    required this.onPressed,
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        primary: const Color(0xFF65558F), // Button background color
        minimumSize: const Size(30, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 7, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
