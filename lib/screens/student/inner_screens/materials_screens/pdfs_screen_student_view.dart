import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:uni_assest/models/student_get_section_model.dart';
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
      body: FutureBuilder<dynamic>(
        future: _isLecture? futureLectures:futureSections,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                      Text('Lecture ${lecture.number}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
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

