
class GetPostModel {
  final String id;
  final String? title;
  final String? description;
  final Publisher? publisher; // Make Publisher nullable
  final List<dynamic> likes;
  final List<dynamic> comments;
  final int version;
  final String generatedAt;

  GetPostModel({
    required this.id,
    this.title,
    this.description,
    this.publisher,
    required this.likes,
    required this.comments,
    required this.version,
    required this.generatedAt,
  });

  factory GetPostModel.fromJson(Map<String, dynamic> json) {
    return GetPostModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publisher: json['publisher'] != null && json['publisher']!.isNotEmpty
          ? Publisher.fromJson(json['publisher'])
          : null, // Handle empty publisher
      likes: List<dynamic>.from(json['likes'] ?? []),
      comments: List<dynamic>.from(json['comments'] ?? []),
      version: json['__v'] ?? 0,
      generatedAt: json['generatedAt'] ?? '',
    );
  }
}

class Publisher {
  //final String id;
  final String name;

  Publisher({
    //required this.id,
    required this.name,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      //id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
