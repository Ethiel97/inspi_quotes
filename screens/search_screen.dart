import 'package:flutter/material.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/view_models/quote_view_model.dart';
import 'package:smart_quotes/views/base_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseView<QuoteViewModel>(
        key: UniqueKey(),
        vmBuilder: (context) => QuoteViewModel(),
        builder: _buildScreen,
      );

  Widget _buildScreen(context, QuoteViewModel quoteViewModel) {
    return Container();
  }
}
