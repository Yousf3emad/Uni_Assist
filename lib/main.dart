import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/theme_data.dart';
import 'package:uni_assest/providers/theme_provider.dart';
import 'package:uni_assest/root_screen.dart';
import 'package:uni_assest/screens/attendance_screen.dart';
import 'package:uni_assest/screens/auth/login_screen.dart';
import 'package:uni_assest/screens/auth/register_screen.dart';


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
          theme: Styles.themeData(isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          initialRoute: RegisterScreen.routeName,
          routes: {
            RootScreen.routeName: (context) => const RootScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            AttendanceScreen.routeName: (context) => AttendanceScreen(),
          },
        );
      }),
    );
  }
}
/*
* MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: ViewAttendance(),
        );
      }),
    );
* */
