import 'package:flutter/material.dart';

import '../../consts/my_validators.dart';

class TxtFormFieldWidget extends StatelessWidget {
  const TxtFormFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.validateFct,
    required this.onSubmitFct,
    this.textInputAction = TextInputAction.next,
    this.label = "",
    this.hintTxt,
    this.prefixIcon,
    this.preIconColor,
    this.suffixIcon,
    this.obSecure = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Function validateFct;
  final Function onSubmitFct;
  final String? label;
  final String? hintTxt;
  final IconData? prefixIcon;
  final Color? preIconColor;
  final IconData? suffixIcon;
  final bool obSecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSecure,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: (value){
        onSubmitFct();
      },
      validator: (value) {
         return validateFct(value);
      },
      decoration: InputDecoration(
        label: Text(label!),
        hintText: hintTxt,
        prefixIcon: Icon(prefixIcon,
          color: preIconColor,
        ),
        suffixIcon: Icon(suffixIcon),
      ),
    );
  }
}
