import 'package:flutter/material.dart';
import 'package:shopping/widgets/Button.dart';

class ErrorStateWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorStateWidget({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel_outlined, // Error icon
                  size: 30,
                  color: Color(0xFFB71C1C),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Something went wrong', // Error message
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Button(label: 'Refresh', onPressed: onRetry)
              ],
            )));
  }
}
