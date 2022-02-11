import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_quotes/repositories/api_repository.dart';
import 'package:smart_quotes/utils/constants.dart';

abstract class BaseViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  bool _isInitializeDone = false;
  bool _hasError = false;

  String errorMessage = "";

  final String? defaultLocale =
      WidgetsBinding.instance?.window.locale.languageCode ?? "en";

  FutureOr<void> _initState;

  final APIRepository apiRepository = APIRepository(apiUrl: apiUrl);

  int get size => 0;

  int get favSize => 0;

  BaseViewModel() {
    _init();
  }

  FutureOr<void> init();

  void _init() async {
    isLoading = true;
    _initState = init();
    await _initState;
    _isInitializeDone = true;
    isLoading = false;
  }

  void changeStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void reloadState() {
    if (!isLoading) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  //Getters
  FutureOr<void> get initState => _initState;

  bool get isLoading => _isLoading;

  bool get isDisposed => _isDisposed;

  bool get isInitialized => _isInitializeDone;

  bool get hasError => _hasError;

  set error(bool error) {
    _hasError = error;
    notifyListeners();
  }

  //Setters
  set isLoading(bool value) {
    _isLoading = value;
    scheduleMicrotask(() {
      if (!_isDisposed) notifyListeners();
    });
  }
}
