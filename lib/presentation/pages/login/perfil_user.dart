import 'package:flutter/material.dart';
import '/core/theme/app_theme.dart';


class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

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

            const Text(
              "Usuário Logado",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),
            const Text(
              "email@empresa.com",
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.textSecondary,
              ),
            ),

            const SizedBox(height: 25),

            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Alterar Senha"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: const Text("Permissões"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
