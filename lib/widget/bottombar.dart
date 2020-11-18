import 'package:flutter/material.dart';

Widget bottomBar(
    ValueChanged<int> onTap, int currentIndex, bool showChallenge) {
  // Add logic about show challeng
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
    BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Plank'),
    BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Challenge'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  return BottomNavigationBar(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    items: bottomNavItems,
    currentIndex: currentIndex,
    onTap: onTap,
  );
}
