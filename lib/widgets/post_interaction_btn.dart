import 'package:flutter/material.dart';


Widget postInteractionBtn({
  required BuildContext context,
  required String txt,
  required IconData icon,
  Color? iconColor,
  Color? txtColor,
}) => MaterialButton(
  height: 40.0,
  onPressed: (){},
  //color: Provider.of<ThemeProvider>(context).getIsDarkTheme? Colors.black : Colors.white,
  elevation: 0.0,
  child: Row(
    children: [
      Icon(icon,color: iconColor,),
      const SizedBox(width: 7.0,),
      Text(
        txt,style: TextStyle(
          color: txtColor,
      ),
      ),
    ],
  ),
);