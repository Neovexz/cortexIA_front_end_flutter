import 'package:flutter/material.dart';
import 'package:front_end_flutter_cortex_ia/presentation/pages/login.dart';
import 'package:provider/provider.dart';

import '/presentation/pages/main_page.dart';
import '/core/theme/app_theme.dart';

// Controllers
import 'package:front_end_flutter_cortex_ia/presentation/controllers/ChamadoController.dart';
import 'package:front_end_flutter_cortex_ia/presentation/controllers/ChatController.dart';

// Services
import 'package:front_end_flutter_cortex_ia/data/services/ChamadoService.dart';
import 'package:front_end_flutter_cortex_ia/data/services/ChatService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ChamadoController(ChamadoService()),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatController(ChatService()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/login",
          routes: {
            "/login": (_) => LoginPage(),
            "/main": (_) => MainPage(),
          },
        ));
  }
}
