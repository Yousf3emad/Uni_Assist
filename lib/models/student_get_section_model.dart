class StudentGetSectionModel {
  final int number;
  final String url;
  final String publicId;
  final String generatedAt;

  StudentGetSectionModel({
    required this.number,
    required this.url,
    required this.publicId,
    required this.generatedAt,
  });

  factory StudentGetSectionModel.fromJson(Map<String, dynamic> json) {
    return StudentGetSectionModel(
      number: json['number'],
      url: json['fileUrl']['url'],
      publicId: json['fileUrl']['publicId'],
      generatedAt: json['generatedAt'],
    );
  }
}

class SectionsResponse {
  final String status;
  final String message;
  final List<StudentGetSectionModel>? sections;

  SectionsResponse({
    required this.status,
    required this.message,
    required this.sections,
  });

  factory SectionsResponse.fromJson(Map<String, dynamic> json) {
    var SectionsList = json['Section'] as List?;
    List<StudentGetSectionModel>? Section = SectionsList?.map((i) => StudentGetSectionModel.fromJson(i)).toList();

    return SectionsResponse(
      status: json['status'],
      message: json['message'],
      sections: Section,
    );
  }
}
