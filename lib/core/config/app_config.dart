class AppConfig {
  const AppConfig({required this.baseUrl});

  factory AppConfig.fromEnvironment() {
    const override = String.fromEnvironment('KEEPLY_API_BASE_URL');
    return const AppConfig(
      baseUrl: override == '' ? 'http://localhost:3000' : override,
    );
  }

  final String baseUrl;
}
