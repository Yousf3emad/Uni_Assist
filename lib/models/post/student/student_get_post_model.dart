class StudentGetAllPostsModel {
  final String id;
  final String title;
  final String description;
  final String uploadedBy;
  final String imageUrl;
  final List<dynamic> likes;
  final List<dynamic> comments;
  final String publisherName; // Added field for publisher name
  final String generatedAt; // Added field for generatedAt

  StudentGetAllPostsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadedBy,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.publisherName,
    required this.generatedAt,
  });

  factory StudentGetAllPostsModel.fromJson(Map<String, dynamic> json) {
    print('Parsing post: $json');
    return StudentGetAllPostsModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      uploadedBy: json['publisher']?['name'] ?? '', // Access publisher name from nested structure
      imageUrl: '', // You need to parse this from the 'image' field if available
      likes: json['likes'] ?? [],
      comments: json['comments'] ?? [],
      publisherName: json['publisher']?['name'] ?? '',
      generatedAt: json['generatedAt'] ?? '',
    );
  }
}

class PostsResponse {
  final String status;
  final String message;
  final List<StudentGetAllPostsModel> posts;
  final int postCount;

  PostsResponse({
    required this.status,
    required this.message,
    required this.posts,
    required this.postCount,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    var postsJson = json['posts'] as List;
    List<StudentGetAllPostsModel> postsList = postsJson
        .map((postJson) => StudentGetAllPostsModel.fromJson(postJson))
        .toList();

    print('Parsed posts response: $json');

    return PostsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      posts: postsList,
      postCount: json['postCount'] ?? 0,
    );
  }
}




// // post_model.dart
//
// class StudentGetAllPostsModel {
//   final String id;
//   final String title;
//   final String description;
//   final String uploadedBy;
//   final String imageUrl;
//   final List<dynamic> likes;
//   final List<dynamic> comments;
//
//   StudentGetAllPostsModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.uploadedBy,
//     required this.imageUrl,
//     required this.likes,
//     required this.comments,
//   });
//
//   factory StudentGetAllPostsModel.fromJson(Map<String, dynamic> json) {
//     print('Parsing post: $json');
//     return StudentGetAllPostsModel(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       uploadedBy: json['uploadedBy'] ?? '',
//       imageUrl: json['Image']?['url'] ?? '',
//       likes: json['likes'] ?? [],
//       comments: json['comments'] ?? [],
//     );
//   }
// }
//
// class PostsResponse {
//   final String? status;
//   final String? message;
//   final List<StudentGetAllPostsModel>? posts;
//   final int? postCount;
//
//   PostsResponse({
//     required this.status,
//     required this.message,
//     required this.posts,
//     required this.postCount,
//   });
//
//   factory PostsResponse.fromJson(Map<String, dynamic> json) {
//     var postsJson = json['posts'] as List;
//     List<StudentGetAllPostsModel> postsList = postsJson.map((i) => StudentGetAllPostsModel.fromJson(i)).toList();
//
//     print('Parsed posts response: ${json}');
//
//     return PostsResponse(
//       status: json['status'] ?? '',
//       message: json['message'] ?? '',
//       posts: postsList,
//       postCount: json['postCount'] ?? 0,
//     );
//   }
// }
