class ProfAttendanceModel {
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

  ProfAttendanceModel({
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

  factory ProfAttendanceModel.fromJson(Map<String, dynamic> json) {
    return ProfAttendanceModel(
      subject: json['subject'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      week1: json['week1'] ?? 'absent',
      week2: json['week2'] ?? 'absent',
      week3: json['week3'] ?? 'absent',
      week4: json['week4'] ?? 'absent',
      week5: json['week5'] ?? 'absent',
      week6: json['week6'] ?? 'absent',
      week7: json['week7'] ?? 'absent',
      total: json['total'] ?? 0,
    );
  }
}
