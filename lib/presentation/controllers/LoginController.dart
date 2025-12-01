import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../pages/main_page.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService auth = AuthService();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // DEBUG LOGS
    debugPrint("=======================================");
    debugPrint("➡ DEBUG LOGIN - DADOS DIGITADOS");
    debugPrint("Email digitado: '$email'");
    debugPrint("Senha digitada: '$password'");
    debugPrint("=======================================");

    if (email.isEmpty || password.isEmpty) {
      _snackbar(context, "Preencha todos os campos!");
      return;
    }

    // LOGIN LOCAL TEMPORÁRIO (modo dev)
    if (email == "client@test.com" && password == "test") {
      debugPrint("✔ LOGIN APROVADO");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
      return;
    }

    // Enviando para backend
    debugPrint("➡ Enviando JSON para API:");
    debugPrint({"email": email, "password": password}.toString());
    debugPrint("=======================================");

    isLoading = true;
    notifyListeners();

    final result = await auth.login(email, password);

    isLoading = false;
    notifyListeners();

    if (result.success) {
      // Caso seu AuthResult não tenha token, evite chamar result.token aqui
      debugPrint("✔ LOGIN OK - resultado: ${result.message}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
    } else {
      debugPrint("❌ LOGIN FALHOU: ${result.message}");
      _snackbar(context, result.message);
    }
  }

  // Método privado para mostrar SnackBar — garanta que esteja dentro da classe
  void _snackbar(BuildContext context, String msg) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
