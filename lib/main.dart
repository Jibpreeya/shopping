import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/shopping_screen.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env");
    print("Environment variables loaded successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFEF7FF),
          primary: const Color(0xFF65558F),
          background: const Color(0xFFFEF7FF),
        ),
      ),
      home: const MyHomePage(title: ''),
      // initialRoute: '/$initialRoute',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Define the content for each tab
  final List<Widget> _pages = [
    ShoppingScreen(), // Shopping tab content
    CartScreen(), // Cart tab content
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// For reset to the shopping tab
  void resetSelectedIndex() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: const Color(0xFFF3EDF7),
              iconSize: 15,
              selectedLabelStyle: const TextStyle(
                fontSize: 8, // Adjust size for selected label
                fontWeight: FontWeight.bold, // Optional: Make it bold
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 8, // Adjust size for unselected label
              ),
              items: [
                BottomNavigationBarItem(
                  icon: _buildIconWithBorderRadius(
                      Icons.stars, _selectedIndex == 0),
                  label: 'Shopping',
                  backgroundColor: Color(0xFF65558F),
                ),
                BottomNavigationBarItem(
                  icon: _buildIconWithBorderRadius(
                      Icons.stars, _selectedIndex == 1),
                  label: 'Cart',
                  backgroundColor: Color(0xFF65558F),
                ),
              ],
            ),
    );
  }

  Widget _buildIconWithBorderRadius(IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xFFE8DEF8)
            : Colors.transparent, // Background color for selected
        borderRadius: BorderRadius.circular(30), // Apply borderRadius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Icon(
        icon,
        color: isSelected
            ? Colors.black
            : Colors.grey, // Change icon color based on selection
        // size: 15, // Icon size
      ),
    );
  }
}
