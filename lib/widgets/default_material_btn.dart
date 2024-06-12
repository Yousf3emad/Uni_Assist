import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

Widget defaultMaterialBtn({
  final double btnHeight = kBottomNavigationBarHeight,
  final double? btnWidth,
  final Color btnColor = AppColors.primaryColor,
  final double brdrRadius = 15.0,
  required Function onPressed,
  required Widget child,
}) =>
    MaterialButton(
      height: btnHeight,
      minWidth: btnWidth,
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(brdrRadius),
      ),
      onPressed: () {
        onPressed();
      },
      child: child,
    );