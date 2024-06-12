import 'package:flutter/material.dart';

Widget subTitleTextWidget({
  required String txt,
  int? maxLines,
  bool isOverflow = true,
  Color? color,
  double fontSize = 18.0,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration textDecoration = TextDecoration.none,
  TextOverflow overFlow = TextOverflow.ellipsis,
  TextAlign textAlign = TextAlign.start,
}) =>
    Text(
      textAlign: textAlign,
      txt,
      maxLines: maxLines,
      style: TextStyle(

        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: isOverflow ? overFlow : null,
        fontStyle: fontStyle,
        decoration: textDecoration,
      ),
    );
