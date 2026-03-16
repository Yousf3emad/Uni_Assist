import 'dart:io'; // Use dart:io for file operations

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/models/student_get_section_model.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';
import '../../../../models/student_get_lecture_model.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../shared/remote/api_manager.dart';
import '../../../../widgets/default_material_btn.dart';

class PdfsScreen extends StatefulWidget {
  static const String routeName = "PdfsScreen";

  const PdfsScreen({super.key});

  @override
  _PdfsScreenState createState() => _PdfsScreenState();
}

class _PdfsScreenState extends State<PdfsScreen> {
  File? _selectedFile;
  String? _fileName;
  String? _errorMessage;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
        _errorMessage = null; // Clear error message when a file is picked
      });
    } else {
      // User canceled the picker
    }
  }

  late Future<LectureResponse> futureLectures;
  late Future<SectionsResponse> futureSections;
  late List<String> args;
  bool _isLecture = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as List<String>;

    futureLectures = ApiManager.fetchLectures(lectureId: args[1]);
    _isLecture = true;

    futureSections = ApiManager.fetchSections(sectionId: args[1]);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titleTextWidget(txt: args[2]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<dynamic>(
          future: _isLecture ? futureLectures : futureSections,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.drawerColor,
                  ));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.status == 'Error') {
              return Center(
                  child: Text(
                      'Error: ${snapshot.data?.message ?? 'Unknown error'}'));
            }

            final lectures = snapshot.data!.lectures;
            if (lectures == null || lectures.isEmpty) {
              return const Center(child: Text('No lectures available'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                final lecture = lectures[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfViewerScreen(pdfUrl: lecture.url),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        const Icon(Icons.picture_as_pdf,
                            size: 100, color: Colors.red),
                        titleTextWidget(
                          txt: 'Lecture ${lecture.number}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, bottomSheetSetState) {
                  return Container(
                    decoration: BoxDecoration(
                      color: themeProvider.getIsDarkTheme ? Colors.grey[900] : Colors.white,
                      borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9, top: 2.0),
                          width: 140,
                          height: 9,
                          decoration: BoxDecoration(
                            color: themeProvider.getIsDarkTheme
                                ? AppColors.drawerColor
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        titleTextWidget(
                          txt: "Add new File",
                          color: themeProvider.getIsDarkTheme
                              ? Colors.white
                              : null,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        InkWell(
                          onTap: () async {
                            await _pickFile();
                            bottomSheetSetState(() {});
                            print("File => Picked Successfully");
                            print("File => $_fileName");
                            print("File Path => $_selectedFile");
                          },
                          child: _selectedFile == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 140,
                                color: AppColors.customGrayColor,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              subTitleTextWidget(
                                txt: "Tap to Pick a File",
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                              : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0),
                            child: titleTextWidget(
                                txt: _fileName.toString(),
                                color: Colors.red),
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                        const Spacer(),
                        defaultMaterialBtn(
                          btnColor: AppColors.drawerColor,
                          onPressed: () async {
                            if (_selectedFile != null && _fileName != null) {
                              var response = await ApiManager.uploadFile(
                                  _selectedFile!.path, "HCI", 4);
                              print("Adding file: $_fileName");
                              Navigator.pop(context);
                            } else {
                              bottomSheetSetState(() {
                                _errorMessage =
                                "Please select a file before adding.";
                              });
                            }
                          },
                          btnWidth: double.infinity,
                          child: titleTextWidget(
                            color: Colors.white,
                            txt: "Add",
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          backgroundColor: AppColors.drawerColor,
          child: Icon(
            Icons.add,
            size: 35,
            color: themeProvider.getIsDarkTheme ? Colors.white : Colors.white,
          ),
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
}


//**********************************************
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uni_assest/consts/app_colors.dart';
// import 'package:uni_assest/shared/remote/api_manager.dart';
// import 'package:uni_assest/widgets/sub_title_text_widget.dart';
//
// import '../../../../providers/theme_provider.dart';
// import '../../../../widgets/default_material_btn.dart';
// import '../../../../widgets/title_text_widget.dart';
//
// class PdfsScreen extends StatefulWidget {
//   const PdfsScreen({Key? key}) : super(key: key);
//
//   static const String routeName = "PdfsScreen";
//
//   @override
//   State<PdfsScreen> createState() => _PdfsScreenState();
// }
//
// class _PdfsScreenState extends State<PdfsScreen> {
//   File? _selectedFile;
//   String? _fileName;
//   String? _errorMessage;
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//         _fileName = result.files.single.name;
//         _errorMessage = null; // Clear error message when a file is picked
//       });
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     final String args = ModalRoute.of(context)!.settings.arguments as String;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: titleTextWidget(txt: args),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         child: GridView.builder(
//           physics: const BouncingScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisExtent: 50,
//             mainAxisSpacing: 18,
//           ),
//           itemBuilder: (context, index) => Container(
//             padding: const EdgeInsets.all(12.0),
//             height: MediaQuery.of(context).size.width * 0.3,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18.0),
//               color: themeProvider.getIsDarkTheme
//                   ? AppColors.drawerColor
//                   : AppColors.customGrayColor,
//             ),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       print("View Lecture ${index + 1}");
//                     },
//                     child: FittedBox(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(
//                             Icons.folder_copy,
//                             color: themeProvider.getIsDarkTheme
//                                 ? Colors.white
//                                 : Colors.grey[700],
//                           ),
//                           const SizedBox(
//                             width: 6.0,
//                           ),
//                           SizedBox(
//                             width: size.width * 0.24,
//                             child: subTitleTextWidget(
//                               overFlow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                               txt: "$args ${index + 1}",
//                               color: themeProvider.getIsDarkTheme
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       print("Download Lecture ${index + 1}");
//                     },
//                     child: Icon(
//                       Icons.save_alt_outlined,
//                       color: themeProvider.getIsDarkTheme
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           itemCount: 25, // Adjust itemCount as per your actual data
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           isExtended: true,
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) => StatefulBuilder(
//                 builder: (context, bottomSheetSetState) {
//                   return Container(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max, // Ensure minimal height
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 9, top: 2.0),
//                           width: 140,
//                           height: 9,
//                           decoration: BoxDecoration(
//                             color: themeProvider.getIsDarkTheme
//                                 ? AppColors.drawerColor
//                                 : Colors.grey.shade400,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         titleTextWidget(
//                           txt: "Add new File",
//                           color: themeProvider.getIsDarkTheme ? Colors.white : null,
//                         ),
//                         const SizedBox(
//                           height: 32,
//                         ),
//                         const SizedBox(
//                           height: 24.0,
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             await _pickFile();
//                             bottomSheetSetState(() {});
//                             print("File => Picked Successfully");
//                             print("File => $_fileName");
//                             print("File Path => $_selectedFile");
//                           },
//                           child: _selectedFile == null
//                               ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.upload_file,
//                                 size: 140,
//                                 color: AppColors.customGrayColor,
//                               ),
//                               const SizedBox(
//                                 height: 6,
//                               ),
//                               subTitleTextWidget(
//                                 txt: "Tap to Pick a File",
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ],
//                           )
//                               : Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 12.0),
//                             child: titleTextWidget(txt: _fileName.toString(),color: Colors.red),
//                           ),
//                         ),
//                         if (_errorMessage != null) ...[
//                           const SizedBox(height: 10),
//                           Text(
//                             _errorMessage!,
//                             style: const TextStyle(color: Colors.red),
//                           ),
//                         ],
//                         const Spacer(),
//                         defaultMaterialBtn(
//                           btnColor: AppColors.drawerColor,
//                           onPressed: () async {
//                             if (_selectedFile != null && _fileName != null) {
//                               var response = await ApiManager.uploadFile(_selectedFile!.path, "HCI", 4);
//                               print("Adding file: $_fileName");
//                               Navigator.pop(context);
//                             } else {
//                               bottomSheetSetState(() {
//                                 _errorMessage = "Please select a file before adding.";
//                               });
//                             }
//                           },
//                           btnWidth: double.infinity,
//                           child: titleTextWidget(
//                             color: Colors.white,
//                             txt: "Add",
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 24.0,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//           backgroundColor: AppColors.drawerColor,
//           child: Icon(
//             Icons.add,
//             size: 35,
//             color: themeProvider.getIsDarkTheme ? Colors.white : Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
