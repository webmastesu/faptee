import 'package:fapapp/screens/home_screen.dart';
import 'package:fapapp/screens/search_screen.dart';
import 'package:fapapp/themes/theme.dart';
import 'package:fapapp/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Use light theme only
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(),
            SearchScreen(),
            Center(child: Text('Save Screen')),
            Center(child: Text('Bookmark Screen')),
            Center(child: Text('Profile Screen')),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}