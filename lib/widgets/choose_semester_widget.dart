import 'package:flutter/material.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../consts/app_colors.dart';

Future chooseSemesterWidget({
  required BuildContext context,
  required Color backgroundColor,
  required Function fctSemester1,
  required Function fctSemester2,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Center(
        child: titleTextWidget(txt: "Semester ?", color: Colors.amberAccent),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              fctSemester1();
            },
            child: subTitleTextWidget(
              txt: "Semester 1",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              fctSemester2();
            },
            child: subTitleTextWidget(
              txt: "Semester 2",
            ),
          ),
        ],
      ),
    ),
  );
}
