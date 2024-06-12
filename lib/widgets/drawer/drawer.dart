import 'package:flutter/material.dart';
import 'package:uni_assest/consts/app_colors.dart';

import '../../screens/attendance_screen.dart';
import '../../services/assets_manager.dart';
import '../custom_list_tile_widget.dart';
import '../sub_title_text_widget.dart';
import '../title_text_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * .82,
      backgroundColor: AppColors.drawerColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(top: 12.0),
              child: FittedBox(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    //Profile Image
                    Container(
                      height: size.width * 0.3,
                      width: size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    //Horizontal Space
                    const SizedBox(
                      width: 10.0,
                    ),
                    //Name & Email
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        titleTextWidget(
                            txt: "Youssef Emad", color: Colors.white),
                        subTitleTextWidget(
                            txt: "youssef20024@fci.bu.edu.eg",
                            color: Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            titleTextWidget(txt: "General", color: Colors.white),
            const SizedBox(
              height: 20.0,
            ),
            Container(height: 120.0,),
            // customListTile(
            //   imagePath: AssetsManager.attendance,
            //   title: "View Attendance",
            //   function: () async {
            //     await Navigator.pushNamed(context, AttendanceScreen.routeName);
            //   },
            // ),
            // customListTile(
            //   imagePath: AssetsManager.schedule,
            //   title: "View Schedule",
            //   function: () async {
            //     // await Navigator.pushNamed(
            //     //     context, WishlistScreen.routeName);
            //   },
            // ),
            // Divider Line
            const Divider(
              thickness: 1.0,
            ),
            // Settings
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: titleTextWidget(txt: "Settings", color: Colors.white),
            ),
            SwitchListTile(
              secondary: Image.asset(
                AssetsManager.theme,
                height: 30.0,
              ),
              title: const Text(
                "Light Mode",
                style: TextStyle(color: Colors.white),
              ),
              // title: Text(themeProvider.getIsDarkTheme
              //     ? "Dark mode"
              //     : "Light mode"),
              value: false, //themeProvider.getIsDarkTheme,
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
              child: titleTextWidget(txt: "Others", color: Colors.white),
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
                label:
                    const Text("Logout", style: TextStyle(color: Colors.white)),
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
    );
  }
}
