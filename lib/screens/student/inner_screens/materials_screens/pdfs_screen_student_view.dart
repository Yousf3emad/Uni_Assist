import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/models/student_get_section_model.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';
import '../../../../models/student_get_lecture_model.dart';
import '../../../../shared/remote/api_manager.dart';

class PdfsScreenStudentView extends StatefulWidget {
  static const String routeName = "PdfsScreenStudentView";

  const PdfsScreenStudentView({super.key});

  @override
  _PdfsScreenStudentViewState createState() => _PdfsScreenStudentViewState();
}

class _PdfsScreenStudentViewState extends State<PdfsScreenStudentView> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titleTextWidget(txt: args[2] ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<dynamic>(
          future: _isLecture? futureLectures:futureSections,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColors.drawerColor,));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.status == 'Error') {
              return Center(child: Text('Error: ${snapshot.data?.message ?? 'Unknown error'}'));
            }

            final lectures = snapshot.data!.lectures;
            if (lectures == null || lectures.isEmpty) {
              return const Center(child: Text('No lectures available'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                final lecture = lectures[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(pdfUrl: lecture.url),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        const Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
                        titleTextWidget(txt:  'Lecture ${lecture.number}',),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late String localPath;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    downloadAndLoadPdf();
  }

  Future<void> downloadAndLoadPdf() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/temp.pdf';

      final response = await Dio().download(widget.pdfUrl, filePath);
      if (response.statusCode == 200) {
        setState(() {
          localPath = filePath;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to download PDF';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text('Error: $errorMessage'))
          : PDFView(
        filePath: localPath,
        onError: (error) {
          print('Error loading PDF: $error');
          setState(() {
            errorMessage = 'Error loading PDF: $error';
          });
        },
        onRender: (_pages) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}




