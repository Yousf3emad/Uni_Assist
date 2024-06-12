import 'package:flutter/material.dart';

Widget bottomNavigationBarItem({
  required IconData icon,
  required IconData selectedIcon,
  required String label,
}) =>
    NavigationDestination(
      icon: Icon(
        icon,

      ),
      selectedIcon: Icon(
        selectedIcon,
      ),
      label: label,
    );
