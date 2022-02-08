import 'package:flutter_dotenv/flutter_dotenv.dart';

const String appName = 'Quotes';
String apiUrl = '${dotenv.env['API_URL']}';
String quotesScreenSubtitle = 'Your daily read';
