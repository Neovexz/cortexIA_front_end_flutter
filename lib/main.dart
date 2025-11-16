import 'package:flutter/material.dart';
import '/presentation/pages/main_page.dart';
import '/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Suporte Técnico',
      theme: AppTheme.theme,
      home: const MainPage(),
    );
  }
}
