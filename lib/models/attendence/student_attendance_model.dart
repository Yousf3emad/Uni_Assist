class StudentAttendanceModel {
  final String subject;
  final String type;
  final String name;
  final String week1;
  final String week2;
  final String week3;
  final String week4;
  final String week5;
  final String week6;
  final String week7;
  final int total;

  StudentAttendanceModel({
    required this.subject,
    required this.type,
    required this.name,
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
    required this.week5,
    required this.week6,
    required this.week7,
    required this.total,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      subject: json['subject'],
      type: json['type'],
      name: json['name'],
      week1: json['week1'],
      week2: json['week2'],
      week3: json['week3'],
      week4: json['week4'],
      week5: json['week5'],
      week6: json['week6'],
      week7: json['week7'],
      total: json['total'],
    );
  }
}