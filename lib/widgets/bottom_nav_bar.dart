import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.blue : Colors.grey),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: currentIndex == 1 ? Colors.blue : Colors.grey),
          label: 'Search',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save, color: currentIndex == 2 ? Colors.blue : Colors.grey),
          label: 'Save',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, color: currentIndex == 3 ? Colors.blue : Colors.grey),
          label: 'Bookmark',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: currentIndex == 4 ? Colors.blue : Colors.grey),
          label: 'Profile',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}