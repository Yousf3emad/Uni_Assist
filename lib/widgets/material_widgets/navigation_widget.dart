import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../consts/app_colors.dart';
import '../../providers/theme_provider.dart';

Widget navigationWidget({
  required BuildContext context,
  required String img,
  required String title,
}) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return Container(
    padding: const EdgeInsets.all(12.0),
    height: MediaQuery.of(context).size.width * 0.3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      color: themeProvider.getIsDarkTheme? AppColors.drawerColor : AppColors.customGrayColor,
    ),
    child: Center(
      child: ListTile(
        title: Row(
          children: [
            Image.asset(
              img,
              height: 70,
              width: 65,
            ),
            const SizedBox(
              width: 12.0,
            ),
            titleTextWidget(
              txt: title,
              color: themeProvider.getIsDarkTheme ? Colors.white : Colors.black,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 32,
                color:
                    themeProvider.getIsDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
