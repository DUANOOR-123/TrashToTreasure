import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
