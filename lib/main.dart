import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/theme_data.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/screens/auth/login_screen.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/inner_screens/materials_screen/materials_level.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/inner_screens/materials_screen/pdfs_screen.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/root/root_screen.dart';
import 'package:uni_assest/screens/student/inner_screens/materials_screens/pdfs_screen_student_view.dart';
import 'package:uni_assest/screens/student/inner_screens/materials_screens/levels/materials_level_student_view.dart';
import 'package:uni_assest/screens/student/root/student_root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context,),
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            StudentRootScreen.routeName: (context) => const StudentRootScreen(),
            RootScreen.routeName: (context) => const RootScreen(),
            MaterialsLevelStudentViewScreen.routeName: (context) => MaterialsLevelStudentViewScreen(),
            MaterialsLevelScreen.routeName: (context) => MaterialsLevelScreen(),
            //LevelTwoScreen.routeName: (context) => LevelTwoScreen(),
            //LevelThreeScreen.routeName: (context) => LevelThreeScreen(),
            //LevelFourScreen.routeName: (context) => LevelFourScreen(),
            PdfsScreenStudentView.routeName: (context) => const PdfsScreenStudentView(),
            PdfsScreen.routeName: (context) => const PdfsScreen(),
            //SectionsScreen.routeName: (context) => const SectionsScreen(),
          },
        );
      }),
    );
  }
}
