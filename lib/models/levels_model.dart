import 'package:flutter/cupertino.dart';

class LevelModel with ChangeNotifier {
  final String title;
  final String img;
  final Function fct;

  LevelModel({
    required this.title,
    required this.img,
    required this.fct(),
  });
}
