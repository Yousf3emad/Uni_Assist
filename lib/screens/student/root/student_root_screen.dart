import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/screens/student/student_attendance_screen.dart';
import 'package:uni_assest/screens/student/student_materials_screen.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/bottom_navigation_bar_item_widget.dart';
import 'package:uni_assest/widgets/drawer/drawer.dart';

import '../../../consts/app_colors.dart';
import '../student_home_screen.dart';
import '../student_scan_screen.dart';


class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key});

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();

  static const String routeName = "StudentRootScreen";
}

class _StudentRootScreenState extends State<StudentRootScreen> {
  //late final PageController _controller;
  int _currentScreen = 0;
  final List<Widget> _screens = [
    const StudentHomeScreen(),
    const StudentScanScreen(),
    const StudentAttendanceScreen(),
    const StudentMaterialsScreen(),
  ];
  final List<String> titles = [
    "Home",
    "Scan",
    "Attendance",
    "Material",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentScreen],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.student),
          )
        ],
      ),
      body: _screens[_currentScreen],
      bottomNavigationBar: NavigationBar(
        indicatorColor: themeProvider.getIsDarkTheme? Colors.grey[800] : Colors.white,
        backgroundColor: themeProvider.getIsDarkTheme? AppColors.darkScaffoldColor : AppColors.primaryColor,
        destinations: [
          bottomNavigationBarItem(
            icon: IconlyLight.home,
            selectedIcon: IconlyBold.home,
            label: "Home",
          ),
          bottomNavigationBarItem(
            icon: IconlyLight.scan,
            selectedIcon: IconlyBold.scan,
            label: "Scan",
          ),
          bottomNavigationBarItem(
            icon: IconlyLight.paper,
            selectedIcon: IconlyBold.paper,
            label: "Attendance",
          ),
          bottomNavigationBarItem(
            icon: IconlyLight.folder,
            selectedIcon: IconlyBold.folder,
            label: "Material",
          ),
        ],
        height: kBottomNavigationBarHeight + 6,
        selectedIndex: _currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
