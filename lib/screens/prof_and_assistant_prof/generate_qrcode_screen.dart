import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/shared/local/qr_generate/handle.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../providers/theme_provider.dart';

class GenerateQrCodeScreen extends StatelessWidget {
  const GenerateQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.qrCode,width: size.height*.2,color: themeProvider.getIsDarkTheme? AppColors.drawerColor : null,),
          const SizedBox(height: 24.0,),
          SizedBox(
            width: 250,
            height: kBottomNavigationBarHeight-10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: themeProvider.getIsDarkTheme
                        ? AppColors.drawerColor
                        : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                backgroundColor: themeProvider.getIsDarkTheme
                    ? AppColors.darkScaffoldColor
                    : AppColors.primaryColor,
              ),
              onPressed: () async {
                var result = await ApiService.generateQrcode({
                  "type": "no",
                  "sectionNo": "3",
                  "subjectName": "HCI",
                  "week": "3",
                  "group": "GroupC",
                  "department": "CS",
                  "location": "Hall 3",
                  "lecturerName": "wafaa"

                });
                print(result);
              },
              child: titleTextWidget(txt: "Generate Qr Code"),
            ),
          ),
        ],
      ),
    );
  }
}
