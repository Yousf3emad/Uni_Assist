class StudentViewAllSubjectModel {
  final String id;
  final String title;
  final String courseId;
  final int numberOfHours;
  final List<String> lectures;
  final List<String> sections;

  StudentViewAllSubjectModel({
    required this.id,
    required this.title,
    required this.courseId,
    required this.numberOfHours,
    required this.lectures,
    required this.sections,
  });

  factory StudentViewAllSubjectModel.fromJson(Map<String, dynamic> json) {
    return StudentViewAllSubjectModel(
      id: json['_id'],
      title: json['title'],
      courseId: json['ID'], // Adjust field name as per your JSON structure
      numberOfHours: int.parse(json['numberOfHours']),
      lectures: List<String>.from(json['lectures']),
      sections: List<String>.from(json['sections']),
    );
  }
}
