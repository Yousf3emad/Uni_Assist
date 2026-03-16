import 'package:flutter/material.dart';
import 'package:uni_assest/consts/functions/creat_table.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  final List<String> studentsNames = [
    "Youssef Emad",
    "Ahmed",
    "Mahmoud",
    "Ali",
    "Omar",
    "Ziad",
    "Anas",
    "Emad"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AssetsManager.attendance,
                height: 45.0,
              ),
              const SizedBox(
                width: 25.0,
              ),
              titleTextWidget(txt: "...."),
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: createTable(
                dataColumnLabel: "Student Name", subjects: studentsNames),
          ),
        ],
      ),
    );
  }
}
