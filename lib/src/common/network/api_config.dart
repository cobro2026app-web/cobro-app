class ApiConfig {
  static const String baseUrl = 'https://cobro-back-production.up.railway.app';

  static const Duration connectTimeout =
      Duration(seconds: 15);

  static const Duration receiveTimeout =
      Duration(seconds: 15);

  static const Duration sendTimeout =
      Duration(seconds: 15);
}