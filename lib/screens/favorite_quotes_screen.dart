import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
import 'package:smart_quotes/utils/constants.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:smart_quotes/views/base_view.dart';
import 'package:smart_quotes/widgets/w_quote_card.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  const FavoriteQuotesScreen({required Key key}) : super(key: key);

  @override
  State<FavoriteQuotesScreen> createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {

  @override
  Widget build(BuildContext context) => BaseView<QuoteViewModel>(
        key: UniqueKey(),
        vmBuilder: (context) => QuoteViewModel(),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, QuoteViewModel quoteViewModel) =>
      Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Jiffy().yMMMEd.toString(),
                      style: textStyle.apply(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color
                            ?.withOpacity(
                              .5,
                            ),
                        fontSizeDelta: -4,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      favQuotesScreenSubtitle,
                      style: textStyle.apply(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontWeightDelta: 5,
                        fontSizeDelta: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              quoteViewModel.savedQuotes.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Image.asset(
                            "assets/img/empty-${themeProvider.currentTheme}.png",
                            height: 40.h,
                            width: 100.w,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "No saved quotes",
                            textAlign: TextAlign.center,
                            style: textStyle.apply(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: /*TCard(
                        size: Size(
                          100.w,
                          58.h,
                        ),
                        controller: _controller,
                        cards: quoteViewModel.savedQuotes
                            .map(
                              (quote) => WQuoteCard(
                                key: UniqueKey(),
                                quote: quote,
                                viewModel: quoteViewModel,
                                onTranslate: () => {},
                              ),
                            )
                            .toList(),
                        onForward: (index, info) {
                          print(index);
                        },
                        onBack: (index, info) {
                          print(index);
                        },
                        onEnd: () {
                          print('end');
                        },
                      )*/
                          SizedBox(
                        height: 56.h,
                        width: 100.w,
                        child: PageView.builder(
                          pageSnapping: true,
                          itemCount: quoteViewModel.savedQuotes.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                              right: 18.0,
                            ),
                            child: WQuoteCard(
                              key: UniqueKey(),
                              quote: quoteViewModel.savedQuotes[index],
                              viewModel: quoteViewModel,
                              onTranslate: () => {},
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
}
