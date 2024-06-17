import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/widgets/material_widgets/folder_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../../../../providers/theme_provider.dart';
import '../pdfs_screen_student_view.dart';

class MaterialsLevelStudentViewScreen extends StatelessWidget {
   MaterialsLevelStudentViewScreen({super.key});

  static const String routeName = "MaterialsLevelStudentViewScreen";
  //late List<FolderModel> foldersList;

  late List<String> foldersList;

  @override
  Widget build(BuildContext context) {
    // Arguments
    final List<int> args = ModalRoute.of(context)!.settings.arguments as List<int>;

    final themeProvider = Provider.of<ThemeProvider>(context);
    // foldersList = [
    //   FolderModel(
    //     title: "Lectures",
    //     fct: () {
    //       Navigator.pushNamed(
    //         context,
    //         LecturesScreen.routeName,
    //       );
    //     },
    //   ),
    //   FolderModel(
    //     title: "Sections",
    //     fct: () {
    //       Navigator.pushNamed(
    //         context,
    //         SectionsScreen.routeName,
    //       );
    //     },
    //   ),
    // ];
    foldersList = ["Lectures","Sections"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titleTextWidget(txt: "Level ${args[0]} (Semester ${args[1]})"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0,),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, PdfsScreenStudentView.routeName,arguments: foldersList[index]);
                //foldersList[index].fct();
              },
              child: folderWidget(
                context: context,
                title: foldersList[index],
                //title: foldersList[index].title,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 18.0,
            ),
            itemCount: foldersList.length,
          ),
        ),
      ),
    );
  }
}
