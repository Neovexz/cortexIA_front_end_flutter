import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/auth_service.dart';
import '/core/theme/app_theme.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String userEmail = "Carregando...";
  String userRole = "Carregando...";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final auth = AuthService();
    final me = await auth.getUserData();

    if (me == null) {
      // token inválido -> logout
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
      return;
    }

    setState(() {
      userEmail = me["username"];
      userRole = me["role"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0.3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: AppTheme.primary,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 18),

            Text(
              userEmail.split('@')[0],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 15, color: AppTheme.textSecondary),
            ),

            const SizedBox(height: 8),
            Text(
              "Permissão: $userRole",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
