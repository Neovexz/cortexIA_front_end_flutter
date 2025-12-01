import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front_end_flutter_cortex_ia/main.dart';
import 'package:front_end_flutter_cortex_ia/config/app_config.dart';

void main() {
  testWidgets('App loads with dev config', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(config: AppConfig.dev));

    // Espera um frame completo
    await tester.pumpAndSettle();

    expect(find.textContaining('Ambiente:'), findsOneWidget);
    expect(find.textContaining('API:'), findsOneWidget);
  });
}
