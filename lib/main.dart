import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/theme_data.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/screens/auth/login_screen.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/inner_screens/materials_screen/materials_level.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/root/root_screen.dart';
import 'package:uni_assest/screens/student/inner_screens/materials_screens/pdfs_screen_student_view.dart';
import 'package:uni_assest/screens/student/inner_screens/materials_screens/levels/materials_level_student_view.dart';
import 'package:uni_assest/screens/student/root/student_root_screen.dart';
import 'package:uni_assest/shared/local/cashe/login_status.dart';

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
            isDarkTheme: themeProvider.getIsDarkTheme,
            context: context,
          ),

          home: FutureBuilder<bool>(
            future: LoginStatus.isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data == true) {
                return FutureBuilder<String>(
                  future: LoginStatus.getRole(),
                  builder: (context, roleSnapshot) {
                    if (roleSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (roleSnapshot.hasData) {
                      if (roleSnapshot.data == 'student') {
                        return const StudentRootScreen(); // Redirect to student screen if role is student
                      } else {
                        return const RootScreen(); // Redirect to other screen if role is not student
                      }
                    } else {
                      return const LoginScreen(); // In case of error or no data
                    }
                  },
                );
              } else {
                return const LoginScreen(); // Redirect to login screen if not logged in
              }
            },
          ),
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            StudentRootScreen.routeName: (context) => const StudentRootScreen(),
            RootScreen.routeName: (context) => const RootScreen(),
            MaterialsLevelStudentViewScreen.routeName: (context) =>
                const MaterialsLevelStudentViewScreen(),
            MaterialsLevelScreen.routeName: (context) => MaterialsLevelScreen(),
            PdfsScreenStudentView.routeName: (context) =>
                 const PdfsScreenStudentView(),
            PdfsScreenStudentView.routeName: (context) =>  const PdfsScreenStudentView(),
          },
        );
      }),
    );
  }
}
