import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

import '../models/chamados/ChamadoModel.dart';
import '../models/chamados/ChamadoCreateModel.dart';

class ChamadoService {
  ChamadoService();

  // ============================================================
  // 🌍 BASE URL GLOBAL (mesmo padrão do ChatService)
  // ============================================================
  static String get root {
    try {
      if (Platform.isAndroid) return "http://10.0.2.2:8080/api/v1";
      if (Platform.isIOS) return "http://localhost:8080/api/v1";
    } catch (_) {}
    return "http://localhost:8080/api/v1"; // Web e Desktop
  }

  // Rota específica deste service
  static String get baseUrl => "$root/chamados";

  // ============================================================
  // 🔍 LISTAR CHAMADOS
  // ============================================================
  Future<List<ChamadoModel>> listarChamados() async {
    final url = Uri.parse(baseUrl);

    if (kDebugMode) print("📡 [GET] $url");

    final response = await http.get(url, headers: _headers());

    if (response.statusCode == 200) {
      if (kDebugMode) print("📥 RECEBIDO: ${response.body}");

      final decoded = jsonDecode(response.body);

      // Backend retorna Page<T>
      if (decoded is Map && decoded.containsKey("content")) {
        return (decoded["content"] as List)
            .map((e) => ChamadoModel.fromJson(e))
            .toList();
      }

      // Backend retorna lista
      if (decoded is List) {
        return decoded.map((e) => ChamadoModel.fromJson(e)).toList();
      }

      throw Exception("Formato inesperado ao listar chamados.");
    }

    throw Exception(
        "Erro ao listar chamados (${response.statusCode}): ${response.body}");
  }

  // ============================================================
  // 🟦 CRIAR CHAMADO
  // ============================================================
  Future<ChamadoModel?> criarChamado(ChamadoCreateModel model) async {
    final url = Uri.parse(baseUrl);

    if (kDebugMode) {
      print("🟦 [POST] $url");
      print("📤 ENVIANDO: ${jsonEncode(model.toJson())}");
    }

    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(model.toJson()),
    );

    if (kDebugMode) {
      print("📥 STATUS: ${response.statusCode}");
      print("📥 BODY: ${response.body}");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ChamadoModel.fromJson(jsonDecode(response.body));
    }

    throw Exception(
      "Erro ao criar chamado (${response.statusCode}): ${response.body}",
    );
  }

  // ============================================================
  // 📦 HEADERS
  // ============================================================
  Map<String, String> _headers() => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
}
