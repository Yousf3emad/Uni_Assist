import 'package:flutter/material.dart';
import 'package:uni_assest/screens/attendance_screen.dart';
import '../services/assets_manager.dart';
import '../widgets/custom_list_tile_widget.dart';
import '../widgets/sub_title_text_widget.dart';
import '../widgets/title_text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                children: [
                  //Profile Image
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //Horizontal Space
                  const SizedBox(
                    width: 10.0,
                  ),
                  //Name & Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleTextWidget(txt: "Youssef Emad"),
                      subTitleTextWidget(txt: "youssef20024@fci.bu.edu.eg"),
                    ],
                  ),
                ],
              ),
            ),
            // General Categories
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleTextWidget(txt: "General"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  customListTile(
                    imagePath: AssetsManager.attendance,
                    title: "View Attendance",
                    function: () async {
                      await Navigator.pushNamed(context, AttendanceScreen.routeName);
                    },
                  ),
                  customListTile(
                    imagePath: AssetsManager.schedule,
                    title: "View Schedule",
                    function: () async {
                      // await Navigator.pushNamed(
                      //     context, WishlistScreen.routeName);
                    },
                  ),
                  // Divider Line
                  const Divider(
                    thickness: 1.0,
                  ),
                  // Settings
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: titleTextWidget(txt: "Settings"),
                  ),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30.0,
                    ),
                    title: const Text("Light Mode"),
                    // title: Text(themeProvider.getIsDarkTheme
                    //     ? "Dark mode"
                    //     : "Light mode"),
                    value: false,//themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                       //themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  // Divider Line
                  const Divider(
                    thickness: 1.0,
                  ),
                  // Privacy & Policy Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: titleTextWidget(txt: "Others"),
                  ),
                  customListTile(
                    imagePath: AssetsManager.privacy,
                    title: "Privacy & Policy",
                    function: () {},
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  // Button
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.login_outlined,
                        color: Colors.white,
                      ),
                      label: const Text("Logout",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () async {
                        // await Navigator.pushNamed(
                        //     context, LoginScreen.routeName);
                        // Warning when the user want to log out
                        // await MyAppMethods.showErrorORWarningDialog(
                        //     context: context,
                        //     isError: false,
                        //     subTitle: "Are you Sure?",
                        //     fct: () {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
