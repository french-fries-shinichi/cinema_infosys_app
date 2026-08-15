import 'ReviewScreen.dart';
import 'homepage.dart';
import 'profilepage.dart';
import 'Aichatbot.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // this to track of the current page to display
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages for TGV
  final List<Widget> _pages = [
    // homepage
    const Homepage(),

    // review page
    const ReviewScreen(),

    // Ai Chatbot
    const Aichatbot(),

    // Profile page
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          items: const [
            // Home
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            // User Reviews
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.reviews),
              label: 'Reviews',
            ),

            // AI Chatbot
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.chat_bubble),
              label: 'Ai Chatbot',
            ),

            // Profile
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}