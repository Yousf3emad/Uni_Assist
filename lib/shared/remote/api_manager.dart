import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_assest/consts/end_points.dart';
import 'package:uni_assest/models/post/add_post_model.dart';
import 'package:uni_assest/shared/local/cashe/login_status.dart';

import '../../models/post/get_post_model.dart';
import '../../models/post/student/student_get_post_model.dart';
import '../../models/upload_lecture_model.dart';

class ApiManager {
  final String baseUrl;

  ApiManager({required this.baseUrl});

  static Future<dynamic> studentLogin(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$BASE_URL$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  static Future<dynamic> profOrAssistLogin(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$BASE_URL$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<List<GetPostModel>> getPosts({
    required String endPoint,
  }) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      print("Success....441");
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        print("data['status'] == 'Success5521124'");
        final List<GetPostModel> posts = (data['posts'] as List)
            .map((postJson) => GetPostModel.fromJson(postJson))
            .toList();
        print(posts);
        return posts;
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<AddPostModel> addPost(AddPostModel post) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/prof-profAssist/post/add-post');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token, // Replace with your token
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Sucess') {
        return AddPostModel.fromJson(data['post'][0]);
      } else {
        throw Exception('Failed to add post: ${data['message']}');
      }
    } else {
      throw Exception('Failed to add post: ${response.reasonPhrase}');
    }
  }

  Future<PostsResponse> fetchStudentPosts() async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl$STUDENT_GetPost'), // Update the endpoint accordingly
      headers: {
        'Content-Type': 'application/json',
        'token': token, // Add your JWT token here
      },
    );

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);
        print('Decoded response: $decodedResponse');
        return PostsResponse.fromJson(decodedResponse);
      } catch (e) {
        print('Failed to parse response: $e');
        throw Exception('Failed to parse response');
      }
    } else {
      print('Failed to load posts: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load posts');
    }
  }

  static Future<UploadedLectureModel?> uploadFile(String filePath) async {

    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$BASE_URL$ADD_LECTURE"),
    );
    request.headers['token'] = token; // Include JWT token in headers
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Status => ${response.statusCode}");
        var decodedResponse = json.decode(response.body);
        print("decodedResponse => ${decodedResponse}");
        if (decodedResponse != null &&
            decodedResponse is Map<String, dynamic>) {
          var uploadedLectureJson = decodedResponse['uploadedlecture'];
          if (uploadedLectureJson != null &&
              uploadedLectureJson is Map<String, dynamic>) {
            return UploadedLectureModel.fromJson(uploadedLectureJson);
          } else {
            print(
                "Upload failed: 'uploadedlecture' is not a valid JSON object");
            return null;
          }
        } else {
          print("Upload failed: Response is not a valid JSON object");
          return null;
        }
      } else {
        print("Upload failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Upload failed: $e");
      return null;
    }
  }
}
