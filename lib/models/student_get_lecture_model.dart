class StudentGetLectureModel {
  final int number;
  final String url;
  final String publicId;
  final String generatedAt;

  StudentGetLectureModel({
    required this.number,
    required this.url,
    required this.publicId,
    required this.generatedAt,
  });

  factory StudentGetLectureModel.fromJson(Map<String, dynamic> json) {
    return StudentGetLectureModel(
      number: json['number'],
      url: json['fileUrl']['url'],
      publicId: json['fileUrl']['publicId'],
      generatedAt: json['generatedAt'],
    );
  }
}

class LectureResponse {
  final String status;
  final String message;
  final List<StudentGetLectureModel>? lectures;

  LectureResponse({
    required this.status,
    required this.message,
    required this.lectures,
  });

  factory LectureResponse.fromJson(Map<String, dynamic> json) {
    var lecturesList = json['lectures'] as List?;
    List<StudentGetLectureModel>? lectures = lecturesList?.map((i) => StudentGetLectureModel.fromJson(i)).toList();

    return LectureResponse(
      status: json['status'],
      message: json['message'],
      lectures: lectures,
    );
  }
}
