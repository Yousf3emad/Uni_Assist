import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'sub_title_text_widget.dart';



Widget customListTile({
  required String imagePath,
  required String title,
  required Function function,
  IconData trailing = IconlyLight.arrowRight2,
  double height = 35,
  Color txtColor = Colors.white,
  Color trailingColor = Colors.white,
}) =>
    SizedBox(
      height: kBottomNavigationBarHeight,
      child: ListTile(
        onTap: () {
          function();
        },
        leading: Image.asset(
          imagePath,
          height: height,
        ),
        title: subTitleTextWidget(
          color: txtColor,
          txt: title,
        ),
        trailing: Icon(trailing,color: trailingColor,),
      ),
    );
