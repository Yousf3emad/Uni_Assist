import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/screens/prof_and_assistant_prof/inner_screens/materials_screen/pdfs_screen.dart';
import 'package:uni_assest/widgets/material_widgets/folder_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../../../../providers/theme_provider.dart';

class MaterialsLevelScreen extends StatelessWidget {
  MaterialsLevelScreen({super.key});

  static const String routeName = "MaterialsLevelScreen";

  late List<String> foldersList;
  late List<String> doctorsNamesList;
  late List<String> assistantProfNamesList;

  @override
  Widget build(BuildContext context) {
    // Arguments
    final List<int> args =
        ModalRoute.of(context)!.settings.arguments as List<int>;

    final themeProvider = Provider.of<ThemeProvider>(context);

    foldersList = ["Lectures", "Sections"];
    doctorsNamesList = [
      "Hamada Nayel",
      "Ahmed Hagag",
      "Mohamed Taha",
      "Mostafa Elgendy"
    ];
    assistantProfNamesList = [
      "Abdalla Mohamed",
      "Mostafa Mohamed",
      "Ahmed Yousry",
      "Mohamed Ali",
    ];

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
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {

                Navigator.pushNamed(context, PdfsScreen.routeName,
                    arguments: foldersList[index]);


              },
              child: folderWidget(
                context: context,
                title: foldersList[index],
                // title: foldersList[index].title,
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
