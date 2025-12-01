import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/theme/app_theme.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/login.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/login/perfil_user.dart';

class UserMenuSheet extends StatelessWidget {
  const UserMenuSheet({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.primary,
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Usuário Logado",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "email@empresa.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          ListTile(
            leading: const Icon(Icons.person_outline, color: AppTheme.primary),
            title: const Text("Ver Perfil"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PerfilPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppTheme.secondary),
            title: const Text("Configurações"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(height: 30),
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.danger),
            title: const Text(
              "Sair da Conta",
              style: TextStyle(
                color: AppTheme.danger,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => _logout(context),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
