import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chamados/ChamadoModel.dart';

class ChamadoService {
  final String baseUrl = "http://localhost:8080/api/chamados"; 
  // depois você troca para o endpoint real

  // -----------------------------
  // LISTAR CHAMADOS DO USUÁRIO
  // -----------------------------
  Future<List<ChamadoModel>> listarChamados() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => ChamadoModel.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao buscar chamados: ${response.statusCode}");
    }
  }

  // -----------------------------
  // CRIAR CHAMADO
  // -----------------------------
  Future<ChamadoModel?> criarChamado(ChamadoModel model) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return ChamadoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao criar chamado: ${response.statusCode}");
    }
  }

  // -----------------------------
  // BUSCAR CHAMADO POR ID
  // -----------------------------
  Future<ChamadoModel?> buscarPorId(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return ChamadoModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}