import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class ApiService {
  static const String baseUrl = 'http://192.168.1.10:5000';

  static Future<Uint8List> generateQrcode(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate_qrcode'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to generate QR code');
    }
  }
}
