import 'package:flutter/material.dart';

class BottomNavigationMenuItem {
  static const home = 0;
  static const properties = 1;
  static const payments = 2;
  static const profile = 3;
}

getBottomNavigationBar(
    {required BuildContext context,
    int currentIndex = BottomNavigationMenuItem.home,
    required ValueChanged<int> onTap}) {
  return BottomNavigationBar(
    elevation: 0,
    currentIndex: currentIndex,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined),
        label: 'Properties',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.credit_card_outlined),
        label: 'Payments',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.cabin_outlined),
        label: 'Payments',
      ),
    ],
  );
}
