import 'package:flutter_dotenv/flutter_dotenv.dart';

const String appName = 'dailyQ';
String apiUrl = '${dotenv.env['API_URL']}';
String translationApiUrl = '${dotenv.env['TRANSLATION_API_URL']}';
String translationApiKey = '${dotenv.env['TRANSLATION_API_KEY']}';
String quotesScreenSubtitle = 'Your daily fuel 😎';
String favQuotesScreenSubtitle = 'Your favorite quotes 😋';
