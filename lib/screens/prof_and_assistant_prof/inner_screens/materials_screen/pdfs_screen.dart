import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../../../../models/upload_lecture_model.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../shared/remote/api_manager.dart';
import '../../../../widgets/default_material_btn.dart';
import '../../../../widgets/title_text_widget.dart';

class PdfsScreen extends StatefulWidget {
  const PdfsScreen({super.key});

  static const String routeName = "PdfsScreen";

  @override
  State<PdfsScreen> createState() => _PdfsScreenState();
}

class _PdfsScreenState extends State<PdfsScreen> {
  late final TextEditingController _titleController;
  late final FocusNode _titleFocusNode;
  bool _isUploading = false;
  String _uploadMessage = '';
  UploadedLectureModel? _uploadedLectureModel;
  String? path;
  String fileName = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'pptx,txt'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          path = file.path;
          fileName = file.name;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("File picking failed: $e");
      setState(() {
        _uploadMessage = "File picking failed: $e";
      });
    }
  }

  void _uploadFile(String filePath) async {
    setState(() {
      _isUploading = true;
      _uploadMessage = "Uploading...";
    });

    UploadedLectureModel? uploadedLecture =
        await ApiManager.uploadFile(filePath);

    setState(() {
      _isUploading = false;
      if (uploadedLecture != null) {
        _uploadMessage = "Upload successful!";
        _uploadedLectureModel = uploadedLecture;
      } else {
        _uploadMessage = "Upload failed.";
      }
    });
  }

  Widget _buildUploadStatus() {
    if (_isUploading) {
      return const CircularProgressIndicator();
    } else if (_uploadMessage.isNotEmpty) {
      return Text(_uploadMessage);
    } else {
      return Container();
    }
  }

  Widget _buildUploadedLectureDetails() {
    if (_uploadedLectureModel == null) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Lecture Uploaded Successfully!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("Lecture ID: ${_uploadedLectureModel!.id}"),
        Text("Number: ${_uploadedLectureModel!.number}"),
        Text("Subject: ${_uploadedLectureModel!.subject}"),
        //Text("Added By: ${_uploadedLectureModel!.addedBy}"),
        Text("File URL: ${_uploadedLectureModel!.fileUrl}"),
        Text("Generated At: ${_uploadedLectureModel!.generatedAt}"),
      ],
    );
  }

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
                              txt: "pdf ${index + 1}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    color: themeProvider.getIsDarkTheme ? Colors.white : null,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  InkWell(
                    onTap: _isUploading ? null : _openFileExplorer,
                    child: path == null
                        ? Column(
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: titleTextWidget(txt: fileName),
                          ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  defaultMaterialBtn(
                    btnColor: AppColors.drawerColor,
                    onPressed: () {
                      if (path != null) {
                        _uploadFile(path!);
                      }
                    },
                    btnWidth: double.infinity,
                    child: titleTextWidget(
                      color: Colors.white,
                      txt: "Upload File",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/*
* import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../widgets/default_material_btn.dart';
import '../../../../widgets/title_text_widget.dart';

class PdfsScreen extends StatefulWidget {
  const PdfsScreen({Key? key}) : super(key: key);

  static const String routeName = "PdfsScreen";

  @override
  State<PdfsScreen> createState() => _PdfsScreenState();
}

class _PdfsScreenState extends State<PdfsScreen> {
  late String fileName = ''; // Initialize fileName as empty string
  String? path;

  void _openFileExplorer(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          path = file.path;
          fileName = file.path.split('/').last; // Get just the file name
        });
        print("File path: $path");
        print("File name: $fileName");
        // Handle the picked file (e.g., upload to server, process locally)
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("File picking failed: $e");
    }
  }

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
                  : AppColors.customGrayColor,
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
                              overFlow: TextOverflow.ellipsis,
                              maxLines: 1,
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
                      print("Download Lecture ${index + 1}");
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
          itemCount: 25, // Adjust itemCount as per your actual data
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max, // Ensure minimal height
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
                      color: themeProvider.getIsDarkTheme ? Colors.white : null,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    // TxtFormFieldWidget(
                    //   controller: _titleController,
                    //   focusNode: _titleFocusNode,
                    //   keyboardType: TextInputType.text,
                    //   label: "title",
                    //   validateFct: () {},
                    //   onSubmitFct: () {},
                    // ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    InkWell(
                      onTap: () {
                        _openFileExplorer(context);
                      },
                      child: path == null
                          ? Column(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: titleTextWidget(txt: fileName),
                            ),
                    ),
                    Spacer(),
                    defaultMaterialBtn(
                      btnColor: AppColors.drawerColor,
                      onPressed: () {
                        // Implement your logic to add the selected file
                        if (path != null) {
                          print("Adding file: $fileName");
                          // Add your logic to process the selected file here
                        }
                        Navigator.pop(context);
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
              ),
            );
          },
          backgroundColor: AppColors.drawerColor,
          child: Icon(
            Icons.add,
            size: 35,
            color: themeProvider.getIsDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

* */
