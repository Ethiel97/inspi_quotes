import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_quotes/utils/colors.dart';

enum ConnectivityStatus { Wifi, Cellular, Offline }

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((event) {
      connectionStatusController.add(_getConnectivityStatusChange(event));
    });
  }

  ConnectivityStatus _getConnectivityStatusChange(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  notify(status) {
    if (status == ConnectivityStatus.Offline) {
      Get.snackbar(
        'Notification',
        "Please! Check your network",
        duration: const Duration(seconds: 7),
        backgroundColor: accentColor,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        colorText: Colors.white,
      );
    }
    /*else {
      Get.snackbar(
        'Notification',
        "You are now connected to a network",
        duration: Duration(seconds: 5),
        backgroundColor: TinyColor(fourthColor).darken().color,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        colorText: Colors.white,
      );
    }*/
  }
}