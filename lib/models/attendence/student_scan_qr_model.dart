class Attendance {
  String type;
  String subjectName;
  String week;

  Attendance({
    required this.type,
    required this.subjectName,
    required this.week,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'subjectName': subjectName,
      'week': week,
    };
  }
}
