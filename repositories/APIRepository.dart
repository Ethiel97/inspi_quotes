import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:smart_quotes/models/author.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/network/api_interceptor.dart';
import 'package:smart_quotes/repositories/IRepository.dart';

///
class APIRepository implements IRrepository {
  static Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  final String apiUrl;

  APIRepository({required this.apiUrl});

  @override
  Future<List<Author>> getAuthors(
      {Map<String, dynamic> query = const {}}) async {
    String url = 'authors';

    query.forEach((key, value) {
      url += "$key=$value&";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Author>.from(data.map((x) => Author.fromJson(x)));
  }

  @override
  Future<List<Quote>> getQuotes({
    Map<String, dynamic> query = const {},
  }) async {
    String url = 'quotes';

    query.forEach((key, value) {
      url += "$key=$value&";
    });

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Quote>.from(data.map((x) => Quote.fromJson(x)));
  }

  @override
  Future<List<Quote>> getQuotesForAutor(String authorId) async {
    String url = 'quotes?$authorId';

    final response = await client.get(Uri.parse(apiUrl + url));

    var data = jsonDecode(response.body);
    return List<Quote>.from(data.map((x) => Quote.fromJson(x)));
  }

  @override
  Future<Quote> getSingleQuote(String quoteId) async {
    String url = "quotes/$quoteId";
    final response = await client.get(Uri.parse(apiUrl + url));

    return Quote.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Quote> getRandomQuote({Map<String, dynamic> query = const {}}) async {
    String url = 'random?';

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
}