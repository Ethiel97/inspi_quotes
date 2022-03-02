import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:smart_quotes/views/base_view.dart';
import 'package:smart_quotes/widgets/w_quote_card.dart';
import 'package:smart_quotes/widgets/w_tag.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseView<QuoteViewModel>(
        key: UniqueKey(),
        vmBuilder: (context) => QuoteViewModel(),
        builder: _buildScreen,
      );

  Widget _buildScreen(context, QuoteViewModel quoteViewModel) =>
      Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 33.h,
          ),
          children: [
            Container(
              // padding: const EdgeInsets.
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TinyColor(Theme.of(context).backgroundColor)
                    .color
                    .lighten()
                    .withOpacity(.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (text) async {
                  await quoteViewModel.filterQuotes(text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    IconlyBold.search,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.search_here,
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              // spacing: 4
              // alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: quoteViewModel.tags
                  .map(
                    (e) => WTag(
                      tag: e,
                      quoteViewModel: quoteViewModel,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 24,
            ),
            quoteViewModel.filteredQuotes.isEmpty
                ? Image.asset(
                    'assets/img/empty-${themeProvider.currentTheme}.png',
                    fit: BoxFit.contain,
                  )
                : SizedBox(
                    height: 56.h,
                    width: 70.w,
                    child: PageView.builder(
                      pageSnapping: true,
                      itemCount: quoteViewModel.filteredQuotes.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          right: 18.0,
                        ),
                        child: WQuoteCard(
                          key: UniqueKey(),
                          quote: quoteViewModel.filteredQuotes[index],
                          viewModel: quoteViewModel,
                          onTranslate: () => {},
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );
}
