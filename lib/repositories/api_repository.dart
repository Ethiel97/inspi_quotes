import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:smart_quotes/models/author.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/models/tag.dart';
import 'package:smart_quotes/network/api_interceptor.dart';
import 'package:smart_quotes/repositories/i_repository.dart';
import 'package:translator/translator.dart';

///
class APIRepository implements IRrepository {
  static Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  final String apiUrl;

  APIRepository({required this.apiUrl});

  @override
  Future<List<Author>> getAuthors({
    Map<String, dynamic> query = const {},
  }) async {
    String url = 'authors?';

    String lastKey = "";
    // query.
    query.forEach((key, value) {
      lastKey = key;
    });

    query.forEach((key, value) {
      url += "$key=$value${lastKey == key ? '' : '&'}";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Author>.from(data['results'].map((x) => Author.fromJson(x)));
  }

  @override
  Future<List<Quote>> getQuotes({
    Map<String, dynamic> query = const {},
  }) async {
    String url = 'quotes?';
    String lastKey = "";
    // query.
    query.forEach((key, value) {
      lastKey = key;
    });

    query.forEach((key, value) {
      url += "$key=$value${lastKey == key ? '' : '&'}";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    // print(data);

    return List<Quote>.from(data['results'].map((x) => Quote.fromJson(x)));
  }

  @override
  Future<List<Tag>> getTags({
    Map<String, dynamic> query = const {},
  }) async {
    String url = 'tags?';

    String lastKey = "";
    // query.
    query.forEach((key, value) {
      lastKey = key;
    });

    query.forEach((key, value) {
      url += "$key=$value${lastKey == key ? '' : '&'}";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Tag>.from(data.map((x) => Tag.fromJson(x)));
  }

  @override
  Future<List<Quote>> getQuotesForAutor(String authorId) async {
    String url = 'quotes?$authorId';

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Quote>.from(data['results'].map((x) => Quote.fromJson(x)));
  }

  @override
  Future<Quote> getSingleQuote(String quoteId) async {
    String url = "quotes/$quoteId";
    final response = await client.get(Uri.parse(apiUrl + url));

    return Quote.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Quote> getRandomQuote({
    Map<String, dynamic> query = const {},
  }) async {
    String url = 'random?';
    String lastKey = "";
    // query.
    query.forEach((key, value) {
      lastKey = key;
    });

    query.forEach((key, value) {
      url += "$key=$value${lastKey == key ? '' : '&'}";
    });

    query.forEach((key, value) {
      url += "$key=$value&";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    return Quote.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Author> getSingleAuthor(String authorId) async {
    String url = "authors/$authorId";

    final response = await client.get(Uri.parse(apiUrl + url));

    return Author.fromJson(jsonDecode(response.body));
  }

  Future<String> translateToAppLocale({
    required String text,
    String source = "en",
    required String target,
  }) async =>
      (await GoogleTranslator().translate(text, from: source, to: target)).text;

  @override
  Future<List<Quote>> getQuotesForTag(String? tags) async {
    String? url = "quotes?";

    url = url + "tags=$tags";

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);

    return List<Quote>.from(data['results'].map((x) => Quote.fromJson(x)));
  }
}
