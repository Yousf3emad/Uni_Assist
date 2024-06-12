import 'package:flutter/material.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/consts/functions/creat_table.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../widgets/sub_title_text_widget.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});
  static String routeName = "ViewAttendance";

  List<String> subject = ["A", "B", "C", "D", "E", "F","G","H"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(onPressed: (){
      //     Navigator.pop(context);
      //   }, icon: const Icon(Icons.keyboard_double_arrow_left_outlined,size: 32.0,),),
      //   backgroundColor: AppColors.customGrayColor,
      //   title:  const Text("UNI ASSIST",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
      //   actions: [Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Image.asset(AssetsManager.student),
      //   )],
      // ),
      body: Padding(
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
              child: createTable(subjects: subject),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* BottomAppBar(
              //shape: CircularNotchedRectangle(),
              height: kBottomNavigationBarHeight,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                        child: Text(
                          "Subject",
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.grey[700]),
                        ),
                        onPressed: () {}),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                        child: Text(
                          "Subject",
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.grey[700]),
                        ),
                        onPressed: () {}),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                        child: Text(
                          "Subject",
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.grey[700]),
                        ),
                        onPressed: () {}),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                        child: Text(
                          "Subject",
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.grey[700]),
                        ),
                        onPressed: () {}),
                    const SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ))
* */

/*
* Table(
                defaultColumnWidth: const FixedColumnWidth(100.0),
                columnWidths: const <int,TableColumnWidth>{
                  // 0:IntrinsicColumnWidth(),
                  // 1:FlexColumnWidth(),
                  // 2:FixedColumnWidth(50),
                },
                border: TableBorder.all(color: AppColors.primaryColor,width: 2.5),
                children: [
                  TableRow(decoration: BoxDecoration(color: AppColors.customGrayColor,),
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(decoration: BoxDecoration(color: AppColors.customGrayColor),
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(decoration: BoxDecoration(color: AppColors.customGrayColor),
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(decoration: BoxDecoration(color: AppColors.customGrayColor),
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(decoration: BoxDecoration(color: AppColors.customGrayColor),
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                      TableCell(child: subTitleTextWidget(txt: "Subject",textAlign: TextAlign.center),),
                    ],
                  ),


                ],
              ),
*
* */
