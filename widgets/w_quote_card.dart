import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:tinycolor2/tinycolor2.dart';

class WQuoteCard extends StatelessWidget {
  const WQuoteCard({
    required Key key,
    required this.quote,
    required this.onTranslate,
    required this.viewModel,
  }) : super(key: key);

  final Quote quote;

  final QuoteViewModel viewModel;

  final VoidCallback onTranslate;

  @override
  Widget build(BuildContext context) =>
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff171717),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              spacing: 8.0,
              children: quote.tags
                  .map(
                    (e) =>
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "#$e",
                        style: textStyle.apply(
                          fontSizeDelta: -4,
                          color: TinyColor(Colors.white).color.withOpacity(.8),
                        ),
                      ),
                    ),
              )
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Text(
                quote.content,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: textStyle.apply(
                  fontSizeDelta: 15.5,
                  fontWeightDelta: 10,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "By ${quote.author}",
              style: textStyle.apply(
                color: Colors.white.withOpacity(.8),
                fontSizeDelta: -2,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                'Read more'.toUpperCase(),
                style: textStyle.apply(
                  color: darkColor,
                  fontSizeDelta: -2,
                ),
              ),
            ),
            // const Spacer(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        viewModel.shareQuote(quote);
                      },
                      color: Colors.white,
                      icon: const Icon(
                        Icons.share,
                        size: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        viewModel.translateQuote(context, quote);

                        onTranslate();
                      },
                      color: Colors.white,
                      icon: const Icon(
                        Icons.translate,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  color: Colors.white,
                  icon: const Icon(
                    Icons.bookmark_border_outlined,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
