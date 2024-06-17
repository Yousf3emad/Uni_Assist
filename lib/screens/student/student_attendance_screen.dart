import 'package:flutter/material.dart';
import 'package:uni_assest/consts/functions/creat_table.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

class StudentAttendanceScreen extends StatelessWidget {
  StudentAttendanceScreen({super.key});

  static String routeName = "StudentAttendanceScreen";

  final List<String> subject = ["A", "B", "C", "D", "E", "F", "G", "H"];

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
              dataColumnLabel: 'Subject Name',
              subjects: subject,
            ),
          ),
        ],
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
