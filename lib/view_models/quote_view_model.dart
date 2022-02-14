import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/main.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_quotes/models/tag.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';

import 'base_view_model.dart';

class QuoteViewModel extends BaseViewModel {
  List<Quote> quotes = [];

  List<Quote> filteredQuotes = [];

  List<Tag> tags = [];

  List<Tag> selectedTags = [];

  late Quote quote;

  @override
  int get size => quotes.length;

  String translatedText = "";
  late Box<Quote> boxQuotes;

  // translatedText

  List<Quote> get savedQuotes => boxQuotes.values.toList();

  @override
  FutureOr<void> init() async {
    boxQuotes = Hive.box(quotesBox);
    await fetchTags();
    await fetchAll(query: {'page': 30, 'limit': 30});
  }

  fetchTags() async {
    tags = await apiRepository.getTags();
    tags.shuffle();
    // selectedTags = [tags[0]];
    filterQuotesByTag();
    reloadState();
  }

  selectTag(Tag tag) async {
    if (selectedTags.where((el) => el.name == tag.name).isEmpty) {
      selectedTags.add(tag);
      reloadState();
      // notifyListeners();
    } else {
      selectedTags.remove(tag);
      reloadState();
      // notifyListeners();
    }
    // reloadState();
    await filterQuotesByTag();
  }

  filterQuotes(String query) async {
    if (query.isNotEmpty) {
      debouncing(fn: () {
        // filteredQuotes.clear();
        changeStatus();
        filteredQuotes = quotes
            .where((element) =>
                element.content.toLowerCase().contains(query.toLowerCase()))
            .toList();
        changeStatus();
        // reloadState();
      });
    }
  }

  filterQuotesByTag() async {
    try {
      changeStatus();
      String tags = selectedTags.map((e) => e.name).toList().join("|");

      print("SELECTED TAGS $tags");

      // filteredQuotes.clear();
      filteredQuotes = (await apiRepository.getQuotesForTag(tags));
      filteredQuotes.shuffle();
      changeStatus();
    } catch (e) {
      print(e);
    } finally {
      finishLoading();
    }
  }

  fetchAll({Map<String, dynamic> query = const {}}) async {
    try {
      changeStatus();
      quotes = await apiRepository.getQuotes(query: query);

      quotes.shuffle();
    } catch (e) {
      print(e);
      debugPrint(e.toString());

      quotes = [];
      tags = [];
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
      finishLoading();
    }
  }

  getQuotesForAuthor(String authorId) async {
    try {
      changeStatus();
      quotes = await apiRepository.getQuotesForAutor(authorId);
      quotes.shuffle();
    } catch (e) {
      debugPrint(e.toString());

      quotes = [];
      error = true;

      errorMessage = "Oops, something went wrong";
    } finally {
      changeStatus();
      finishLoading();
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
      finishLoading();
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
      finishLoading();
    }
  }

  void shareQuote(Quote quote) {
    Share.share("Check out this quote ${quote.content} on Inspi Quotes");
  }

  void translateQuote(BuildContext context, Quote quote) async {
    try {
      String translatedText = await apiRepository.translateToAppLocale(
        text: quote.content,
        source: "en",
        target: defaultLocale ?? "en",
      );

      this.translatedText = translatedText;

      reloadState();
      showTranslateModal(context, this.translatedText);
      /* int quotePosition = quotes.indexOf(quote);

      quote = quote.copyWith(content: translatedText);

      quotes.replaceRange(quotePosition, quotePosition + 1, [quote]);*/

    } catch (e) {
      errorMessage = "Oops, something went wrong";
      print(e);
    } finally {
      finishLoading();
    }
  }

  void bookmark(Quote quote) {
    if (!boxQuotes.containsKey(quote.id)) {
      quote = quote.copyWith(saved: true);
      boxQuotes.put(quote.id, quote);

      Get.snackbar(
        "Notification",
        "Quoted added to your fav list",
      );
    } else {
      unBookmark(quote);
    }

    print("BOOKMARING");
    /*else {
      unBookmark(quote);
    }*/
    reloadState();
  }

  void unBookmark(Quote quote) {
    quote = quote.copyWith(saved: false);

    boxQuotes.delete(quote.id);
    reloadState();

    Get.snackbar(
      "Notification",
      "Quoted remove from your fav list",
      colorText: Colors.white,
    );
  }

  showTranslateModal(BuildContext context, String text) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor.lighten(15),
      context: context,
      builder: (context) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(14),
        // alignment: ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Text(
              "Translation Result",
              style: textStyle.apply(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeightDelta: 5,
                fontSizeDelta: 1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              text,
              style: textStyle.apply(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSizeDelta: 1,
              ),
            ),
          ],
        ),
        height: 24.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
