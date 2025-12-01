import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/controllers/LoginController.dart';
import 'package:front_end_flutter_cortex_ia/presentation/widgets/buttons/primary_button.dart';
import 'package:front_end_flutter_cortex_ia/presentation/widgets/inputs/campo_formulario.dart';

import 'esqueceu_senha.dart';

class LoginPage extends StatelessWidget {
  // 🔥 Controller que controla os campos + validação + chamada ao back-end
  // OBS: quando você quer desligar o backend, você altera lá dentro.
  final LoginController controller = LoginController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // 🎨 Fundo degrade
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // LOGO
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

                  // ==============================
                  // 📌 CAMPO DE EMAIL
                  // ==============================
                  // O controller.emailController guarda o que o usuário digitou
                  CampoFormulario(
                    controller: controller.emailController,
                    label: "Email",
                    hint: "Digite seu email",
                  ),

                  const SizedBox(height: 20),

                  // ==============================
                  // 📌 CAMPO DE SENHA
                  // ==============================
                  CampoFormulario(
                    controller: controller.passwordController,
                    label: "Senha",
                    hint: "Digite sua senha",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // ==============================
                  // 🔗 Botão "Esqueceu senha"
                  // ==============================
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

                  // ==============================
                  // 🔥 BOTÃO DE LOGIN
                  // ==============================
                  // ⬅ AQUI É ONDE O BACK-END É CHAMADO
                  // Quando quiser pular login, trocar para:
                  // onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPage()));
                  // ==============================
                  PrimaryButton(
                    text: "Entrar",
                    onPressed: () => controller.login(context),
                    // 🔥 Aqui chama o backend via LoginController -> AuthService
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
