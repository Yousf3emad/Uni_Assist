import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:uni_assest/screens/attendance_screen.dart';
import 'package:uni_assest/screens/schedule_screen.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/bottom_navigation_bar_item_widget.dart';
import 'package:uni_assest/widgets/drawer/drawer.dart';
import 'consts/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/scan_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();

  static const String routeName = "RootScreen";
}

class _RootScreenState extends State<RootScreen> {
  late final PageController _controller;
  int _currentScreen = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ScanScreen(),
    AttendanceScreen(),
    const ScheduleScreen(),
  ];
  final List<String> titles = [
    "Home",
    "Scan",
    "Attendance",
    "Schedule",
  ];
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentScreen);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.customGrayColor,
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
      body: PageView(
        allowImplicitScrolling: true,
        onPageChanged: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.white,
        //backgroundColor: const Color.fromARGB(255, 21, 119, 86),
        backgroundColor: AppColors.primaryColor,
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
          // bottomNavigationBarItem(
          //   icon: IconlyLight.profile,
          //   selectedIcon: IconlyBold.profile,
          //   label: "Profile",
          // ),
          bottomNavigationBarItem(
            icon: IconlyLight.paper,
            selectedIcon: IconlyBold.paper,
            label: "Attendance",
          ),
          bottomNavigationBarItem(
            icon: IconlyLight.timeCircle,
            selectedIcon: IconlyBold.timeCircle,
            label: "Schedule",
          ),
        ],
        height: kBottomNavigationBarHeight,
        selectedIndex: _currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            _currentScreen = index;
          });
          _controller.jumpToPage(_currentScreen);
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
