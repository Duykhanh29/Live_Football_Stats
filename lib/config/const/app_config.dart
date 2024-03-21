import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();
  static String baseUrl = dotenv.env['baseUrl']!;
  static String authToken = dotenv.env['authToken']!;
  static const String authTokenPara = 'auth_token';
  static String authUrlPath = "?$authTokenPara=$authToken";
}
