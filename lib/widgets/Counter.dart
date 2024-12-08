import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0), // Equal padding
      margin: const EdgeInsets.all(0),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: _decrementCounter,
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
          // const SizedBox(width: 0), // Added spacing between buttons and text
          Text(
            _counter.toString(),
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 0),
          ElevatedButton(
            onPressed: _incrementCounter,
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
        ],
      ),
    );
  }
}
