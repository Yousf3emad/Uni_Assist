import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/material_widgets/folder_widget.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../../../../models/student_view_all_subjectsModel.dart';
import '../../../../../providers/theme_provider.dart';
import '../../../../../shared/remote/api_manager.dart';
import '../pdfs_screen_student_view.dart';

class MaterialsLevelStudentViewScreen extends StatefulWidget {
  const MaterialsLevelStudentViewScreen({super.key});

  static const String routeName = "MaterialsLevelStudentViewScreen";

  @override
  State<MaterialsLevelStudentViewScreen> createState() =>
      _MaterialsLevelStudentViewScreenState();
}

class _MaterialsLevelStudentViewScreenState
    extends State<MaterialsLevelStudentViewScreen> {
  late List<String> foldersList;
  late List<StudentViewAllSubjectModel> subjectsList = []; // Initialize with empty list
  late String lectureOrSection;

  @override
  void initState() {
    super.initState();
    fetchSubjects(); // Call fetchSubjects in initState
  }

  Future<void> fetchSubjects() async {
    try {
      List<StudentViewAllSubjectModel> fetchedSubjects = await ApiManager.fetchSubjects();
      setState(() {
        subjectsList = fetchedSubjects;
      });
    } catch (e) {
      // Handle error
      print('Error fetching subjects: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<int> args =
        ModalRoute.of(context)!.settings.arguments as List<int>;

    final themeProvider = Provider.of<ThemeProvider>(context);
    foldersList = ["Lectures", "Sections"];

    Size size = MediaQuery.of(context).size;
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
                lectureOrSection = foldersList[index];

                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: themeProvider.getIsDarkTheme
                          ? Colors.grey.shade900
                          : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18),
                      ),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: subjectsList.isEmpty
                        ? SizedBox(
                            height: size.height * .3,
                            width: size.width,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.drawerColor,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                titleTextWidget(
                                  txt: "Subject ?",
                                  color: Colors.amberAccent,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, subjIndex) => Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(size.height * .8,
                                            kBottomNavigationBarHeight - 20),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0,
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                          context,
                                          PdfsScreenStudentView.routeName,
                                          arguments: [
                                            lectureOrSection,
                                            subjectsList[subjIndex].id,
                                            subjectsList[subjIndex].title,
                                          ],
                                        );
                                      },
                                      child: subTitleTextWidget(
                                          txt: subjectsList[subjIndex].title),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 12.0,
                                  ),
                                  itemCount: subjectsList.length,
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              },
              child: folderWidget(
                context: context,
                title: foldersList[index],
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


