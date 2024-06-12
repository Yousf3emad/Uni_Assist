import 'package:flutter/material.dart';
import 'app_colors.dart';

//Theme Dark orLight
class Styles {
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) =>
      ThemeData(
        scaffoldBackgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        // cardColor: isDarkTheme
        //     ? const Color.fromARGB(255, 13, 6, 37)
        //     : AppColors.lightCardColor,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          elevation: 0.0,
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
          titleTextStyle: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.all(
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black)),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
          ),
          height: kBottomNavigationBarHeight,
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(letterSpacing: 1.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            borderSide: const BorderSide(color: Colors.grey, width: 1.25),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: const BorderSide(
              color: AppColors.drawerColor,
            ),
          ),
        ),
      );
}
