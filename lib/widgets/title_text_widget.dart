import 'package:flutter/material.dart';

Widget titleTextWidget({
  required String txt,
  int? maxLines,
  bool isOverflow = true,
  Color? color,
  double fontSize = 20.0,
  FontWeight fontWeight = FontWeight.bold,
  TextOverflow overFlow = TextOverflow.ellipsis,
}) =>
    Text(
      txt,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: isOverflow ? overFlow : null,
      ),
    );
