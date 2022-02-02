import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smart_quotes/models/quote.dart';

import 'base_view_model.dart';

class QuoteViewModel extends BaseViewModel {
  List<Quote> quotes = [];

  late Quote quote;

  String? errorMessage;

  @override
  FutureOr<void> init() async {
    await fetchAll();
  }

  fetchAll({Map<String, dynamic> query = const {}}) async {
    try {
      changeStatus();
      quotes = await apiRepository.getQuotes(query: query);
      changeStatus();
    } catch (e) {
      debugPrint(e.toString());

      quotes = [];
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }

  getQuotesForAuthor(String authorId) async {
    try {
      changeStatus();
      quotes = await apiRepository.getQuotesForAutor(authorId);
      changeStatus();
    } catch (e) {
      debugPrint(e.toString());

      quotes = [];
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }

  getRandomQuote({Map<String, dynamic> query = const {}}) async {
    try {
      changeStatus();
      quote = await apiRepository.getRandomQuote(query: query);
    } catch (e) {
      debugPrint(e.toString());
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }

  getSingleQuote(id) async {
    try {
      changeStatus();
      quote = await apiRepository.getSingleQuote(id);
    } catch (e) {
      debugPrint(e.toString());
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }
}
