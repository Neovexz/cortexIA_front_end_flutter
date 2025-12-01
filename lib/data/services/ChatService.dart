import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/chamados/MessageModel.dart';
import '../models/chamados/MessageCreateModel.dart';

class ChatService {
  ChatService();

  static const base = 'http://localhost:8080/api/v1';

  // -----------------------------------------
  // LISTAR MENSAGENS
  // -----------------------------------------
  Future<List<MessageModel>> listarMensagens(int chamadoId) async {
    final url = Uri.parse('$base/chamados/$chamadoId/mensagens');

    final res = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => MessageModel.fromJson(e)).toList();
    }

    throw Exception('Erro listar mensagens: ${res.body}');
  }

  // -----------------------------------------
  // CRIAR TEXTO
  // -----------------------------------------
  Future<MessageModel?> criarMensagem(
      int chamadoId, MessageCreateModel m) async {
    final url = Uri.parse('$base/chamados/$chamadoId/mensagens');

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(m.toJson()),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return MessageModel.fromJson(jsonDecode(res.body));
    }

    throw Exception('Erro criar mensagem: ${res.body}');
  }

  // -----------------------------------------
  // ENVIAR IMAGEM
  // -----------------------------------------
  Future<MessageModel?> enviarImagem(
    int chamadoId,
    File file, {
    required String autor,
  }) async {
    final url = Uri.parse('$base/chamados/$chamadoId/mensagens/imagem');

    final request = http.MultipartRequest('POST', url);

    final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
    final parts = mimeType.split('/');

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType(parts[0], parts[1]),
      ),
    );

    request.fields['autor'] = autor;

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode == 200 || res.statusCode == 201) {
      return MessageModel.fromJson(jsonDecode(res.body));
    }

    throw Exception('Erro enviar imagem: ${res.body}');
  }
}
