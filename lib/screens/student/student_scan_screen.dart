import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/services/qr_code_scanner/qr_code_scanner.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../providers/theme_provider.dart';

class StudentScanScreen extends StatelessWidget {
  const StudentScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side:  BorderSide(color: themeProvider.getIsDarkTheme? AppColors.drawerColor : Colors.transparent
                      , width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                backgroundColor: themeProvider.getIsDarkTheme
                    ? AppColors.darkScaffoldColor
                    : AppColors.primaryColor,
              ),
              onPressed: () {
                QRCodeScanner.scan();
              },
              child: titleTextWidget(txt: "Scan Qr Code"),
            ),
          ),
        ],
      ),
    );
  }
}
