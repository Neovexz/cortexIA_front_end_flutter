import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/config/app_config.dart';
import 'package:front_end_flutter_cortex_ia/core/constants/colors.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/login.dart';


void main() {
  // Escolha o ambiente atual:
  final config = AppConfig.dev;

  runApp(MyApp(config: config));
}

class MyApp extends StatelessWidget {
  final AppConfig config;

  const MyApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final AppConfig config;

  const HomePage({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(config.appName)),
      body: Center(
        child: Text(
            'Ambiente: ${config.environment.name}\nAPI: ${config.apiBaseUrl}'),
      ),
    );
  }
}
