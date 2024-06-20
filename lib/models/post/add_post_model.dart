class AddPostModel {
  //final String id;
  final String title;
  final String description;
  //final String uploadedBy;
  //final String imageUrl;
  // final List<dynamic> likes;
  // final List<dynamic> comments;

  AddPostModel({
    // required this.id,
    required this.title,
    required this.description,
    // required this.uploadedBy,
    // required this.imageUrl,
    // required this.likes,
    // required this.comments,
  });

  factory AddPostModel.fromJson(Map<String, dynamic> json) {
    return AddPostModel(
      //id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      // uploadedBy: json['uploadedBy'] ?? '',
      // imageUrl: json['Image']?['url'] ?? '',
      // likes: json['likes'] ?? [],
      // comments: json['comments'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'_id': id,
      'title': title,
      'description': description,
      // 'uploadedBy': uploadedBy,
      // 'Image': {'url': imageUrl},
      // 'likes': likes,
      // 'comments': comments,
    };
  }
}



//
//
//
// class AddPostModel {
//   final String title;
//   final String description;
//
//
//   AddPostModel({
//     required this.title,
//     required this.description,
//
//   });
//
//   factory AddPostModel.fromJson(Map<String, dynamic> json) {
//     return AddPostModel(
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'description': description,
//     };
//   }
// }
