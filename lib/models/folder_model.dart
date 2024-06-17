import 'package:flutter/cupertino.dart';

class FolderModel with ChangeNotifier {
  final String title;
  final Function fct;

  FolderModel({
    required this.title,
    required this.fct(),
  });
}
