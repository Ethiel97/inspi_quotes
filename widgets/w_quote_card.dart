import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
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
      Consumer2<ThemeProvider, NavigationProvider>(
        builder: (context, themeProvider, navigationProvider, _) => Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: themeProvider.currentTheme == 'dark'
                ? TinyColor(Theme.of(context).backgroundColor).color.tint(5)
                : TinyColor(Theme.of(context).backgroundColor)
                    .color
                    .lighten(15),
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: themeProvider.currentTheme == 'dark'
                  ? whiteBackgroundColor.withOpacity(.09)
                  : screenBackgroundColor.withOpacity(.008),
              width: .8,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: themeProvider.currentTheme == 'dark'
                    ? whiteBackgroundColor.withOpacity(.02)
                    : screenBackgroundColor.withOpacity(.02),
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
                      (e) => GestureDetector(
                        onTap: () {
                          /*navigationProvider.currentIndex = 1;

                          Tag tag =
                          viewModel.tags.firstWhere((tag) => tag.name == e);
                          viewModel.selectTag(tag);*/
                        },
                        child: Text(
                          "#$e",
                          style: textStyle.apply(
                            fontSizeDelta: -4,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.color
                                ?.withOpacity(.8),
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
                    fontSizeDelta: 14,
                    fontWeightDelta: 10,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "By ${quote.author}",
                style: textStyle.apply(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withOpacity(.8),
                  fontSizeDelta: -2,
                ),
              ),
              /*const SizedBox(
                height: 16,
              ),
              MaterialButton(
                elevation: 0.0,
                onPressed: () {},
                color: Theme.of(context).textTheme.bodyText1?.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  'Read more'.toUpperCase(),
                  style: textStyle.apply(
                    color: Theme.of(context).backgroundColor,
                    fontSizeDelta: -2,
                  ),
                ),
              ),*/
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
                        color: Theme.of(context).iconTheme.color,
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
                        color: Theme.of(context).iconTheme.color,
                        icon: const Icon(
                          Icons.translate,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.bookmark(quote);
                    },
                    color: Theme.of(context).iconTheme.color,
                    icon: Icon(
                      quote.saved
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
