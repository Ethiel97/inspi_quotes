import 'package:smart_quotes/models/author.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/models/tag.dart';

abstract class IRrepository<T> {
  Future<List<Quote>> getQuotes({Map<String, dynamic> query = const {}});

  Future<List<Author>> getAuthors({Map<String, dynamic> query = const {}});

  Future<Quote> getSingleQuote(String quoteId);

  Future<Author> getSingleAuthor(String authorId);

  Future<List<Quote>> getQuotesForAutor(String authorId);

  Future<List<Tag>> getTags();

  Future<List<Quote>> getQuotesForTag(String tags);

  Future<Quote> getRandomQuote({Map<String, dynamic> query = const {}});
}
