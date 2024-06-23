import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uni_assest/consts/end_points.dart';
import 'package:uni_assest/models/post/add_post_model.dart';
import 'package:uni_assest/models/student_get_section_model.dart';
import 'package:uni_assest/shared/local/cashe/login_status.dart';

import '../../models/attendence/prof_ttendanceModel.dart';
import '../../models/attendence/student_attendance_model.dart';
import '../../models/post/get_post_model.dart';
import '../../models/post/student/student_get_post_model.dart';
import '../../models/student_get_lecture_model.dart';
import '../../models/student_view_all_subjectsModel.dart';
import '../../models/upload_lecture_model.dart';
import 'package:mime/mime.dart';

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

    //print("Posts = > ${response.body}");

    if (response.statusCode == 200) {
      //print("Success....441");
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        //print("data['status'] == 'Success5521124'");
        //print("data => ${data}");
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

  static Future<UploadedLectureModel?> uploadFile(
      String filePath, String title, int number) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$BASE_URL$ADD_LECTURE"),
    );

    request.fields['title'] = 'Internet of things';
    request.fields['number'] = 5.toString();
    request.headers['token'] = token; // Include JWT token in headers

    // Determine the MIME type of the file
    String? mimeType = lookupMimeType(filePath);
    if (mimeType == null) {
      print("Could not determine MIME type of the file");
      return null;
    }

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      filePath,
      contentType: MediaType.parse(mimeType),
    ));

    print(token);
    print("Request data: ====>>>> $request");
    print(" Path ====>>>> $filePath");

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Status ===> ${response.statusCode}");
        print("Response111111 ===> ${response.body}");
        var decodedResponse = json.decode(response.body);
        print("decodedResponse2222222 => $decodedResponse");
        if (decodedResponse != null &&
            decodedResponse is Map<String, dynamic>) {
          var uploadedLectureJson = decodedResponse['uploadedlecture'];
          print("uploadedLectureJson333333333 => $uploadedLectureJson");
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

  static Future<List<ProfAttendanceModel>> fetchProfAttendance(
      String title) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }
    print(token);

    final response = await http.get(
      Uri.parse('$BASE_URL$VIEW_PROF_LECTURE_ATTENDANCE'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token
      },
      // body: jsonEncode(<String, String>{
      //   'title': title,
      // }),
    );
    print("Response => ${response.statusCode}");
    print("Response => $response");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Response data: $data"); // Debugging line
      if (data['attendanceArray'] != null) {
        try {
          final attendanceList = (data['attendanceArray'] as List)
              .map((item) => ProfAttendanceModel.fromJson(item))
              .toList();
          return attendanceList;
        } catch (e) {
          print("Error parsing attendanceArray: $e"); // Debugging line
          throw Exception('Failed to parse attendance data');
        }
      } else {
        print("attendanceArray is null or missing"); // Debugging line
        throw Exception('Attendance data is null or missing');
      }
    } else {
      print(
          "Failed to load attendance with status code: ${response.statusCode}"); // Debugging line
      throw Exception('Failed to load attendance');
    }
  }

  static Future<List<StudentAttendanceModel>> fetchStudentAttendance() async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$BASE_URL$VIEW_STUDENT_LECTURE_ATTENDANCE'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token
      },
    );
    print("525252525 = > ${response.body}");
    print(token);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse =
          json.decode(response.body)['attendanceArray'];
      List<StudentAttendanceModel> attendances = jsonResponse
          .map((data) => StudentAttendanceModel.fromJson(data))
          .toList();
      return attendances;
    } else {
      throw Exception('Failed to load attendance');
    }
  }

  static Future<String> updateAttendance({
    required String type,
    required String subjectName,
    required String weekNum,
  }) async {
    final token = await LoginStatus.getToken();

    print("Token == >>>>> $token");

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$BASE_URL$STUDENT_SCAN_QR_LECTURE');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(<String, String>{
          // Make sure to use jsonEncode
          'type': type,
          'subjectName': subjectName,
          'week': weekNum,
        }),
      );

      if (response.statusCode == 200) {
        // Successful request
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Success =====>> ${responseData['message']}");
        print("Success =====> ${responseData['status']}");
        return responseData[
            'message']; // Assuming 'message' contains success message
      } else {
        // Request failed
        print(
            "Failed to update attendance. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return 'Failed to update attendance. Status code: ${response.statusCode}';
      }
    } catch (e) {
      // Exception handling
      print("Exception occurred while updating attendance: $e");
      return 'Exception occurred while updating attendance: $e';
    }
  }

  static Future<List<StudentViewAllSubjectModel>> fetchSubjects() async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$BASE_URL$STUDENT_VIEW_ALL_SUBJECTS');
    const maxAttempts = 3; // Maximum number of retry attempts
    const initialDelay =
        Duration(seconds: 2); // Initial delay before first retry
    int attempt = 0;

    while (attempt < maxAttempts) {
      try {
        final response = await http.get(url, headers: {
          'token': token, // Add authorization header
        });

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['subjects'] != null) {
            List<dynamic> subjectsData = jsonResponse['subjects'];
            List<StudentViewAllSubjectModel> subjects = subjectsData
                .map((data) => StudentViewAllSubjectModel.fromJson(data))
                .toList();
            return subjects;
          } else {
            // Print the response body for debugging purposes
            print('Response body: ${response.body}');
            // Handle case where 'subjects' field is missing or null
            throw Exception('Subjects data not found');
          }
        } else if (response.statusCode == 429) {
          // Rate limit exceeded, retry after delay
          attempt++;
          print('Rate limit exceeded, retry attempt $attempt');
          await Future.delayed(initialDelay * attempt); // Exponential backoff
        } else {
          // Handle other HTTP errors
          print('Failed to load subjects: ${response.statusCode}');
          throw Exception('Failed to load subjects: ${response.statusCode}');
        }
      } catch (e) {
        // Handle exceptions
        print('Error fetching subjects: $e');
        throw Exception('Error fetching subjects: $e');
      }
    }

    // If all attempts fail, handle the error accordingly
    print('Failed to fetch subjects after $maxAttempts attempts');
    throw Exception('Failed to fetch subjects after $maxAttempts attempts');
  }

  static Future<LectureResponse> fetchLectures({required String lectureId}) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(
          '$BASE_URL$STUDENT_GET_LECTURES$lectureId'),
      headers: {
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      print("RESPONSE ===>>>> ${response.body}");
      return LectureResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load lectures');
    }
  }

  static Future<SectionsResponse> fetchSections({required String sectionId}) async {
    final token = await LoginStatus.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(
          '$BASE_URL$STUDENT_GET_LECTURES$sectionId'),
      headers: {
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      print("RESPONSE ===>>>> ${response.body}");
      return SectionsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Sections');
    }
  }
}
