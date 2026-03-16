import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/choose_semester_widget.dart';
import '../../consts/app_colors.dart';
import '../../widgets/material_widgets/navigation_widget.dart';
import 'inner_screens/materials_screen/materials_level.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          //border: Border.all(color: AppColors.secondColor),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () {
                        chooseSemesterWidget(
                          context: context,
                          backgroundColor: themeProvider
                              .getIsDarkTheme? AppColors
                              .darkScaffoldColor
                              : Colors.grey,
                          fctSemester1: () {
                            Navigator.pushNamed(
                              context,
                              MaterialsLevelScreen.routeName,
                              arguments: [
                                index + 1,
                                 1,
                              ],
                            );
                          },
                          fctSemester2: () {
                            Navigator.pushNamed(
                              context,
                              MaterialsLevelScreen.routeName,
                              arguments: [
                                index + 1,
                                2,
                              ],
                            );
                          },
                        );
                      },
                      child: navigationWidget(
                        //titleColor: Colors.white,
                        context: context,
                        img: AssetsManager.mobileScan,
                        title: "Level ${index + 1}",
                      ),
                    ),
                separatorBuilder: (context, index) =>
                const SizedBox(
                  height: 24,
                ),
                itemCount: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
