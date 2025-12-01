import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/models/chamados/MessageModel.dart';
import '../../data/models/chamados/MessageCreateModel.dart';
import '../../data/services/ChatService.dart';

class ChatController extends ChangeNotifier {
  final ChatService service;

  ChatController(this.service);

  bool isLoading = false;
  bool sending = false;
  bool iaTyping = false; // IA digitando...
  bool tecnicoTyping = false; // Técnico digitando...

  List<MessageModel> messages = [];

  // -----------------------------------------
  // CARREGAR MENSAGENS
  // -----------------------------------------
  Future<void> loadMessages(int chamadoId) async {
    isLoading = true;
    notifyListeners();

    try {
      messages = await service.listarMensagens(chamadoId);
      messages.sort((a, b) => a.criadoEm.compareTo(b.criadoEm));
    } catch (e) {
      debugPrint("Erro loadMessages: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // -----------------------------------------
  // ENVIAR TEXTO
  // -----------------------------------------
  Future<MessageModel?> sendMessage(
      int chamadoId, MessageCreateModel msg) async {
    sending = true;
    notifyListeners();

    try {
      final created = await service.criarMensagem(chamadoId, msg);

      if (created != null) {
        // ❌ remover messages.add(created);

        await Future.delayed(const Duration(milliseconds: 250));
        await loadMessages(chamadoId);
      }

      return created;
    } catch (e) {
      debugPrint("Erro sendMessage: $e");
      return null;
    } finally {
      sending = false;
      notifyListeners();
    }
  }

  // -----------------------------------------
  // ENVIAR IMAGEM
  // -----------------------------------------
  Future<MessageModel?> sendImage(
    int chamadoId,
    File file, {
    required String autor,
  }) async {
    sending = true;
    notifyListeners();

    try {
      final created = await service.enviarImagem(chamadoId, file, autor: autor);

      if (created != null) {
        // ❌ remover messages.add(created);

        await Future.delayed(const Duration(milliseconds: 250));
        await loadMessages(chamadoId);
      }

      return created;
    } catch (e) {
      debugPrint("Erro sendImage: $e");
      return null;
    } finally {
      sending = false;
      notifyListeners();
    }
  }

  // -----------------------------------------
  // IA DIGITANDO
  // -----------------------------------------
  void showIaTyping() {
    iaTyping = true;
    notifyListeners();
  }

  void hideIaTyping() {
    iaTyping = false;
    notifyListeners();
  }

  // -----------------------------------------
  // TÉCNICO DIGITANDO
  // -----------------------------------------
  void showTecnicoTyping() {
    tecnicoTyping = true;
    notifyListeners();
  }

  void hideTecnicoTyping() {
    tecnicoTyping = false;
    notifyListeners();
  }
}
