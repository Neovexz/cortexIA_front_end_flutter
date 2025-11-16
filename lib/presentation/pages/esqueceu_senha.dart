import 'package:flutter/material.dart';
import '../controllers/esqueceu_senha_controller.dart';
import '../widgets/inputs/campo_formulario.dart';
import '../widgets/buttons/primary_button.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  late final EsqueceuSenhaController controller;

  @override
  void initState() {
    super.initState();
    controller = EsqueceuSenhaController();
    controller.onUpdate = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6D00),
              Color(0xFFD500F9),
              Color(0xFF2979FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título
                  const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Campo de email
                  CampoFormulario(
                    controller: controller.emailController,
                    label: "Email",
                    hint: "Digite o email...",
                  ),
                  const SizedBox(height: 24),

                  // Botão ou loading
                  controller.isLoading
                      ? const CircularProgressIndicator()
                      : PrimaryButton(
                          text: "Enviar link de troca de senha",
                          onPressed: () => controller.enviarLink(context),
                          type: ButtonType.gradient,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
