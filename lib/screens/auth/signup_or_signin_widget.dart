import 'package:flutter/material.dart';

import '../../consts/app_colors.dart';
import '../../widgets/title_text_widget.dart';

class SignUpOrSignInWidget extends StatelessWidget {
  const SignUpOrSignInWidget({super.key,required this.txt,required this.txtBtn,required this.onPressedFct});
  final String txt;
  final String txtBtn;
  final Function onPressedFct;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        titleTextWidget(
            txt: txt,
            fontWeight: FontWeight.w600),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: TextButton(
            onPressed: () {
              onPressedFct();
            },
            child: Text(
              txtBtn,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w400,
                color: AppColors.drawerColor,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}