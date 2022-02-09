import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';

import 'base_view_model.dart';

class QuoteViewModel extends BaseViewModel {
  List<Quote> quotes = [];

  late Quote quote;

  int get total => quotes.length;

  String translatedText = "";

  // translatedText

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
      print(e);
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

  void shareQuote(Quote quote) {
    Share.share("Check out this quote ${quote.content} on Inspi Quotes");
  }

  void translateQuote(BuildContext context, Quote quote) async {
    try {
      String translatedText = await apiRepository.translateToAppLocale(
        text: quote.content,
        source: "en",
        target: "it",
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
    }
  }

  showTranslateModal(BuildContext context, String text) {
    // showBottomSheet(context: context, builder: builder)/
    showModalBottomSheet(
      backgroundColor: const Color(0xff171717).withOpacity(.8),
      context: context,
      builder: (context) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(14),
        // alignment: ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Result",
              style: textStyle.apply(
                color: Colors.white,
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
                color: Colors.white,
                fontSizeDelta: 1,
              ),
            ),
          ],
        ),
        height: 24.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: const Color(0xff171717).withOpacity(.8),
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(.092),
            width: .8,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              color: TinyColor(darkColor).color.withOpacity(.02),
            )
          ],
        ),
      ),
    );
  }
}
