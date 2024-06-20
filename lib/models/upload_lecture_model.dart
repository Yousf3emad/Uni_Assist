class UploadedLectureModel {
  final String id;
  final int number;
  final String subject;
  final String addedByName;
  final String fileUrl;
  final String filePublicId;
  final String generatedAt;

  UploadedLectureModel({
    required this.id,
    required this.number,
    required this.subject,
    required this.addedByName,
    required this.fileUrl,
    required this.filePublicId,
    required this.generatedAt,
  });

  factory UploadedLectureModel.fromJson(Map<String, dynamic> json) {
    return UploadedLectureModel(
      id: json['_id'],
      number: json['number'],
      subject: json['subject'],
      addedByName: json['addedBy']['name'],
      fileUrl: json['fileUrl']['url'],
      filePublicId: json['fileUrl']['publicId'],
      generatedAt: json['generatedAt'],
    );
  }
}
