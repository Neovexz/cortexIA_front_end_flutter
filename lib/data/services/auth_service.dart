import 'dart:convert';
import 'package:front_end_flutter_cortex_ia/data/models/chamados/auth_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        "email": email, // ← AQUI ARRUMADO
        "password": password,
      }),
    );

    print("📨 BODY ENVIADO: ${jsonEncode({
          "email": email,
          "password": password
        })}");
    print("📩 RESPOSTA SERVIDOR: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_token", data["token"]);
      await prefs.setString("user_email", data["email"]);
      await prefs.setString("user_role", data["role"]);
      await prefs.setInt("user_id", data["id"]);
      await prefs.setString("user_nome", data["nome"]);

      return AuthResult.fromJson(data);
    }

    return AuthResult.error("Credenciais inválidas");
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
