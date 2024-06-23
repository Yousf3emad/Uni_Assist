import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/screens/auth/login_screen.dart';
import 'package:uni_assest/shared/local/cashe/login_status.dart';
import '../../services/assets_manager.dart';
import '../../services/my_app_methods.dart';
import '../custom_list_tile_widget.dart';
import '../sub_title_text_widget.dart';
import '../title_text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 0.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: Drawer(
          width: size.width * .78,
          backgroundColor: themeProvider.getIsDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.drawerColor,
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        //Horizontal Space
                        const SizedBox(
                          height: 12.0,
                        ),
                        //Name & Email
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            titleTextWidget(
                                txt: "Youssef Emad", color: Colors.white),
                            const SizedBox(
                              height: 6.0,
                            ),
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
                Container(
                  height: 120.0,
                ),
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
                  activeColor: AppColors.primaryColor,
                  activeTrackColor: AppColors.primaryColor,
                  secondary: Image.asset(
                    AssetsManager.theme,
                    height: 30.0,
                  ),
                  title: subTitleTextWidget(
                      txt: themeProvider.getIsDarkTheme
                          ? "Dark mode"
                          : "Light mode",
                      color: Colors.white),
                  value: themeProvider.getIsDarkTheme,
                  onChanged: (value) {
                    themeProvider.setDarkTheme(themeValue: value);
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
                    label: const Text("Logout",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      //Warning when the user want to log out
                      MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        fctConfirmation: () {
                          LoginStatus.logout();
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) =>
                                false, // Removes all previous routes
                          );
                        },
                        fctCancel: (){
                          Navigator.pop(context);
                        },
                        isError: false,
                        subTitle: "Log Out ?",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
