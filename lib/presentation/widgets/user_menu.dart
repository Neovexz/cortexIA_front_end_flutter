import 'package:flutter/material.dart';
import '/core/theme/app_theme.dart';
import '../pages/login/perfil_user.dart';

class UserMenuSheet extends StatelessWidget {
  const UserMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Linha da "alça" superior
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(height: 20),

          // Nome e foto
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

          // Opção 1 - Ver perfil
          ListTile(
            leading: const Icon(Icons.person_outline, color: AppTheme.primary),
            title: const Text("Ver Perfil"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PerfilPage(),
                ),
              );
            },
          ),

          // Opção 2 - Configurações
          ListTile(
            leading: const Icon(Icons.settings, color: AppTheme.secondary),
            title: const Text("Configurações"),
            onTap: () {
              Navigator.pop(context);
              // navega para configurações
            },
          ),

          // Divider
          const Divider(height: 30),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.danger),
            title: const Text(
              "Sair da Conta",
              style: TextStyle(color: AppTheme.danger),
            ),
            onTap: () {
              // Aqui você faz o logout
              Navigator.pop(context);

              // Voltar para tela de login
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
