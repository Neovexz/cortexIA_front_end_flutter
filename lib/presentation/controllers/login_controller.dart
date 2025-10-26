import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print("Preencha todos os campos!");
      return;
    }

    // Aqui você chamaria sua API de login
    print("Login com: $email / $password");
  }
}
