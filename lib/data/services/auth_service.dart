import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final bool success;
  final String message;

  AuthResult(this.success, this.message);
}

class AuthService {
  final String baseUrl = "http://localhost:8080";

  /// ============================
  /// LOGIN
  /// ============================
  Future<AuthResult> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_token", data["token"]);
      await prefs.setString("user_email", email);

      // Buscar dados reais do usuário
      final me = await getUserData();
      if (me != null) {
        await prefs.setString("user_role", me["role"]);
      }

      return AuthResult(true, "Login OK");
    }

    return AuthResult(false, "Credenciais inválidas");
  }

  /// ============================
  /// GET USER DATA (usa token)
  /// ============================
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");

    if (token == null) return null;

    final url = Uri.parse("$baseUrl/auth/me");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  /// ============================
  /// LOGOUT
  /// ============================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
