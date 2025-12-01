import 'package:flutter/material.dart';
import 'dart:async';

class EsqueceuSenhaController {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  VoidCallback? onUpdate;

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> enviarLink(BuildContext context) async {
    final email = emailController.text.trim();

    // Campo vazio
    if (email.isEmpty) {
      _showSnackBar(context, "Por favor, insira seu email");
      return;
    }

    // Email inválido
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar(context, "Por favor, insira um email válido");
      return;
    }

    isLoading = true;
    onUpdate?.call();

    try {
      await Future.delayed(const Duration(seconds: 2));

      // Email não encontrado
      if (email.contains("naoencontrado")) {
        _showSnackBar(context, "Email não encontrado");
        return;
      }

      // Sucesso
      _showCustomDialog(context, "Link enviado com sucesso!", success: true);
    } catch (e) {
      _showSnackBar(context, "Erro de conexão: $e");
    } finally {
      isLoading = false;
      onUpdate?.call();
    }
  }

  // SnackBar para erros
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, String message,
      {bool success = true}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                success ? Icons.check_circle_outline : Icons.error_outline,
                size: 60,
                color: success ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: success ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
