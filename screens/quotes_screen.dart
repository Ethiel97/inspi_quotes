import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/utils/constants.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:smart_quotes/views/base_view.dart';
import 'package:smart_quotes/widgets/w_quote_card.dart';
import 'package:tcard/tcard.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({required Key key}) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final TCardController _controller = TCardController();

  @override
  Widget build(BuildContext context) {
    return BaseView<QuoteViewModel>(
        key: UniqueKey(),
        vmBuilder: (context) => QuoteViewModel(),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, QuoteViewModel quoteViewModel) =>
      Column(
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
                    color: Colors.white.withOpacity(
                      .5,
                    ),
                    fontSizeDelta: -4,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  quotesScreenSubtitle,
                  style: textStyle.apply(
                    color: Colors.white,
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
          TCard(
            size: Size(100.w, 60.h),
            controller: _controller,
            cards: quoteViewModel.quotes
                .map(
                  (quote) => WQuoteCard(key: UniqueKey(), quote: quote),
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
          ),
        ],
      );
}
