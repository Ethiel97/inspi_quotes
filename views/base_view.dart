import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      !viewModel.isInitialized
          ? Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
              children: [
                widget.builder(context, viewModel),
                Visibility(
                  visible: viewModel.isLoading,
                  child: const Center(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            );
}
