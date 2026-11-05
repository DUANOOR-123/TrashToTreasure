import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  // Backend address for a physical Android phone
  // connected to the laptop through USB.
  static const String baseUrl = "http://127.0.0.1:5000";

  // Check whether Node.js backend is responding
  static Future<Map<String, dynamic>> checkHealth() async {
    final url = Uri.parse("$baseUrl/api/health");

    final response = await http.get(url).timeout(const Duration(seconds: 10));

    final data = jsonDecode(response.body);

    if (data is! Map<String, dynamic>) {
      throw Exception("Invalid response from server");
    }

    if (response.statusCode != 200) {
      throw Exception(data["message"] ?? "Server request failed");
    }

    return data;
  }

  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String contact,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/api/auth/register");

    final response = await http
        .post(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "fullName": fullName,
            "contact": contact,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body);

    if (data is! Map<String, dynamic>) {
      throw Exception("Invalid response from server");
    }

    if (response.statusCode != 201) {
      throw Exception(data["message"] ?? "Registration failed");
    }

    return data;
  }

  static Future<Map<String, dynamic>> login({
    required String contact,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/api/auth/login");

    final response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "contact": contact,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body);

    if (data is! Map<String, dynamic>) {
      throw Exception("Invalid response from server");
    }

    if (response.statusCode != 200) {
      throw Exception(data["message"] ?? "Login failed");
    }

    return data;
  }

  static Future<Map<String, dynamic>> updateRole({
    required String role,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/api/auth/role");

    final response = await http
        .patch(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode({
            "role": role,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        data["message"] ?? "Could not save role",
      );
    }

    return data;
  }

  static Future<Map<String, dynamic>> updateLocation({
    required double latitude,
    required double longitude,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/api/auth/location");

    final response = await http
        .patch(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode({
            "latitude": latitude,
            "longitude": longitude,
          }),
        )
        .timeout(const Duration(seconds: 15));

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        data["message"] ?? "Could not save location",
      );
    }

    return data;
  }

  static Future<http.MultipartFile> _imagePart(String field, String path) {
    final isPng = path.toLowerCase().endsWith('.png');
    return http.MultipartFile.fromPath(
      field,
      path,
      contentType: MediaType('image', isPng ? 'png' : 'jpeg'),
    );
  }

  static Future<Map<String, dynamic>> submitVerification({
    required String frontImagePath,
    required String backImagePath,
    required String selfieImagePath,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/api/auth/verification");
    final request = http.MultipartRequest("POST", url);

    request.headers["Authorization"] = "Bearer $token";

    request.files.add(await _imagePart("cnicFront", frontImagePath));
    request.files.add(await _imagePart("cnicBack", backImagePath));
    request.files.add(await _imagePart("selfie", selfieImagePath));

    final streamed = await request.send().timeout(const Duration(seconds: 60));
    final response = await http.Response.fromStream(streamed);

    // debugPrint-style logs
    // ignore: avoid_print
    print("UPLOAD STATUS: ${response.statusCode}");
    // ignore: avoid_print
    print("UPLOAD RESPONSE: ${response.body}");

    Map<String, dynamic> data;
    try {
      data = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Backend returned an invalid response: ${response.body}");
    }

    if (response.statusCode != 200) {
      throw Exception(data["message"] ?? "ID verification failed");
    }
    return data;
  }
}
