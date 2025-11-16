import 'package:flutter/material.dart';
import '../widgets/inputs/campo_formulario.dart';
import '../controllers/login_controller.dart';
import '../widgets/buttons/primary_button.dart';
import 'esqueceu_senha.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = LoginController();

  LoginPage({super.key});

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
              height: 650,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
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
                mainAxisAlignment: MainAxisAlignment
                    .center, // 🔥 Centraliza tudo verticalmente
                crossAxisAlignment:
                    CrossAxisAlignment.center, // 🔥 Centraliza horizontalmente
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 200,
                    ),
                    child: Image.asset(
                      'assets/images/logo-cortexia-colorida.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo Email
                  CampoFormulario(
                    controller: controller.emailController,
                    label: "Email",
                    hint: "Digite um email...",
                  ),
                  const SizedBox(height: 20),

                  // Campo Senha
                  CampoFormulario(
                    controller: controller.passwordController,
                    label: "Senha",
                    obscureText: true,
                    hint: "Digite o nome...",
                  ),
                  const SizedBox(height: 10),

                  // Esqueceu senha alinhado à direita
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EsqueceuSenha(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange.shade700,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("Esqueceu senha?"),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botão principal
                  PrimaryButton(
                    text: "Entrar",
                    onPressed: controller.login,
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
