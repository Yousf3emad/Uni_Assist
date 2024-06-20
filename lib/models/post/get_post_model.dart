import 'dart:convert';

class GetPostModel {
  final String id;
  final String? title;
  final String? description;
  final Publisher? publisher;
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
      title: json['title'],
      description: json['description'],
      publisher: json['publisher'] != null ? Publisher.fromJson(json['publisher']) : null,
      likes: List<dynamic>.from(json['likes'] ?? []),
      comments: List<dynamic>.from(json['comments'] ?? []),
      version: json['__v'] ?? 0,
      generatedAt: json['generatedAt'] ?? '',
    );
  }
}

class Publisher {
  final String id;
  final String name;

  Publisher({
    required this.id,
    required this.name,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Photo {
  final String url;
  final dynamic publicId;

  Photo({
    required this.url,
    this.publicId,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'] ?? '',
      publicId: json['publicId'],
    );
  }
}

class ProfilePhoto {
  final String url;
  final dynamic publicId;

  ProfilePhoto({
    required this.url,
    this.publicId,
  });

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(
      url: json['url'] ?? '',
      publicId: json['publicId'],
    );
  }
}
