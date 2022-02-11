import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:smart_quotes/view_models/base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T Function(BuildContext) vmBuilder;
  final Widget Function(BuildContext, T) builder;

  const BaseView({
    required Key key,
    required this.vmBuilder,
    required this.builder,
  }) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
        value: widget.vmBuilder(context),
        child: Consumer<T>(
          builder: _buildScreenContent,
        ),
      );

  Widget _buildScreenContent(
    BuildContext context,
    T viewModel,
    Widget? child,
  ) =>
      Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => SizedBox(
          height: 100.h,
          child: !viewModel.isInitialized
              ? Container(
                  height: 100.h,
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    viewModel.hasError
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/404-${themeProvider.currentTheme}.png",
                                  height: 40.h,
                                  width: 100.w,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  viewModel.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: textStyle.apply(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : widget.builder(
                            context,
                            viewModel,
                          ),
                    Visibility(
                      visible: viewModel.isLoading,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
}
