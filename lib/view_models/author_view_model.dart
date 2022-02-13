import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:smart_quotes/models/author.dart';

import 'base_view_model.dart';

class AuthorViewModel extends BaseViewModel {
  List<Author> authors = [];

  late Author author;

  @override
  FutureOr<void> init() {}

  fetchAll({Map<String, dynamic> query = const {}}) async {
    try {
      changeStatus();
      authors = await apiRepository.getAuthors(query: query);
      changeStatus();
    } catch (e) {
      debugPrint(e.toString());

      authors = [];

      error = true;
      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }

  getSingleAuthor(String authorId) async {
    try {
      changeStatus();
      author = await apiRepository.getSingleAuthor(authorId);
    } catch (e) {
      debugPrint(e.toString());
      error = true;
      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
    }
  }
}
