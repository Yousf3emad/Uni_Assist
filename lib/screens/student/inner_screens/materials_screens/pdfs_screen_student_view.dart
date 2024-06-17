import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../widgets/title_text_widget.dart';

class PdfsScreenStudentView extends StatelessWidget {
  const PdfsScreenStudentView({super.key});

  static const String routeName = "PdfsScreenStudentView";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final String args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titleTextWidget(txt: args),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          //shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 50,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: themeProvider.getIsDarkTheme
                  ? AppColors.drawerColor
                  : AppColors.customGrayColor, //Colors.grey[400],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print("View Lecture ${index + 1}");
                    },
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.folder_copy,
                            color: themeProvider.getIsDarkTheme
                                ? Colors.white
                                : Colors.grey[700],
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          SizedBox(
                            width: size.width * 0.24,
                            child: subTitleTextWidget(
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              txt: "$args ${index + 1}",
                              color: themeProvider.getIsDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("download lecture ${index + 1}");
                    },
                    child: Icon(
                      Icons.save_alt_outlined,
                      color: themeProvider.getIsDarkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: 25,
        ),
      ),
    );
  }
}
