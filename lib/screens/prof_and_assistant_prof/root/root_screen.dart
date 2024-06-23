import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/generate_qrcode_screen.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/bottom_navigation_bar_item_widget.dart';
import 'package:uni_assest/widgets/drawer/drawer.dart';

import '../../../consts/app_colors.dart';
import '../attendance_screen.dart';
import '../home_screen.dart';
import '../materials_screen.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();

  static const String routeName = "RootScreen";
}

class _RootScreenState extends State<RootScreen> {
  //late final PageController _controller;
  int _currentScreen = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const GenerateQrCodeScreen(),
    const AttendanceScreen(),
     const MaterialsScreen(),
  ];
  final List<String> titles = [
    "Home",
    "QR Code",
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
            child: Image.asset(AssetsManager.doctor),
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
            label: "Qr Code",
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
