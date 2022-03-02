import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_quotes/models/author.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'base_view_model.dart';

class AuthorViewModel extends BaseViewModel {
  List<Author> authors = [];

  late Author author;

  @override
  FutureOr<void> init() {
    errorMessage = AppLocalizations.of(Get.context!)!.something_went_wrong;
  }

  fetchAll({Map<String, dynamic> query = const {}}) async {
    try {
      changeStatus();
      authors = await apiRepository.getAuthors(query: query);
      changeStatus();
    } catch (e) {
      debugPrint(e.toString());

      authors = [];

      error = true;
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
    } finally {
      changeStatus();
    }
  }
}
