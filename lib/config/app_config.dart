enum AppEnvironment { development, staging, production }

class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final AppEnvironment environment;
  final bool enableLogging;

  const AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
    this.enableLogging = false,
  });

  // Instâncias para cada ambiente
  static const dev = AppConfig(
    appName: 'Cortex IA (Dev)',
    apiBaseUrl: 'https://dev.api.cortexia.com.br',
    environment: AppEnvironment.development,
    enableLogging: true,
  );

  static const staging = AppConfig(
    appName: 'Cortex IA (Homologação)',
    apiBaseUrl: 'https://staging.api.cortexia.com.br',
    environment: AppEnvironment.staging,
  );

  static const prod = AppConfig(
    appName: 'Cortex IA',
    apiBaseUrl: 'https://api.cortexia.com.br',
    environment: AppEnvironment.production,
  );
}
