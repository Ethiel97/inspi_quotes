import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tinycolor2/tinycolor2.dart';

var successColor = TinyColor(Colors.green).darken(3).color;

String? validator(String text) {
  return text.isEmpty ? "Veuillez remplir ce champ" : null;
}

String? emailValidator(String value) {
  if (value.isEmpty || !value.isValidEmail) {
    return "Veuillez entrer un email valide";
  } else {
    return null;
  }
}

extension TimeOfDayUtils on TimeOfDay {
  String formatTimeOfDay() {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return Jiffy(dt).Hm;
  }
}

extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidJWT {
    final jwtRegExp =
        RegExp("^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*\$");
    return jwtRegExp.hasMatch(this);
  }

  bool get isValidUrl {
    final urlRegExp = RegExp(
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
        caseSensitive: false);
    return urlRegExp.hasMatch(this);
  }

  int? toInt() {
    return int.tryParse(this);
  }

  String fromNow() {
    return Jiffy(this, "yyyy-MM-do h:mm:ss").fromNow();
  }

  String toHumanReadable() {
    return Jiffy(this, "yyyy-MM-do H:mm:ss").yMMMMEEEEdjm;
  }

  String format() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(toInt()! * 1000);

    return Jiffy(dateTime, 'MM/yy/dd hh:mm').yMd.toString();
//    return this != null ? Jiffy(this).yMMMMEEEEdjm.toString() : "NON ETABLI";
  }

  bool isValTGNumber() {
    final tgcelRegExp = RegExp("^[9,7][0-3][0-9]{6}");
    final moovRegExp = RegExp('^[9,7][6-9][0-9]{6}');
    return tgcelRegExp.hasMatch(this) || moovRegExp.hasMatch(this);
  }

  String formatNumber() => replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');

  String capitalize() => substring(0, 1).toUpperCase() + substring(1);

/*
  Future<File> urlToFile() async {
    // generate random number.
    var rng = Random();
    // get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();

    // get temporary path from temporary directory.
    String tempPath = tempDir.path;

    // create a new file in temporary path with random file name.
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');

    // call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(this);

    // write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);

    // now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }
*/
}

extension NumberExtensions on num {
  String formatNumber() => toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
}

extension DateTimeExtensions on DateTime {
  String getDateFromDateTime() => toLocal().toString().split(' ')[0];

  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}

extension ScreenUtils<T> on BuildContext {
  double screenHeight({double percent = 1}) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth({double percent = 1}) =>
      MediaQuery.of(this).size.width * percent;
}

extension MyNavigator on BuildContext {
  navigateReplace(Widget route, {isDialog = false}) =>
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(
          fullscreenDialog: isDialog,
          builder: (context) => route,
        ),
      );

  navigateReplaceNamed(String route, {arguments = const {}}) =>
      Navigator.of(this).pushReplacementNamed(
        route,
        arguments: arguments,
      );

  navigateNamed(String route, {arguments = const {}}) =>
      Navigator.of(this).pushNamed(
        route,
        arguments: arguments,
      );

  navigate(Widget route, {isDialog = false}) => Navigator.of(this).push(
        MaterialPageRoute(
          fullscreenDialog: isDialog,
          builder: (context) => route,
        ),
      );

  /*customNavigate(Widget route, {isDialog = false}) => Navigator.of(this).push(
        OpenRoute(page: route),
      );*/

  popView({var data}) {
    if (Navigator.canPop(this)) {
      Navigator.pop(this, data);
    }
  }

  popUntil(String routeName) {
    if (Navigator.canPop(this)) {
      Navigator.of(this).popUntil(ModalRoute.withName(routeName));
    }
  }
}

extension FileExtension on FileSystemEntity {
  String? get name {
    return path.split("/").last;
  }

  String? get extension {
    return name?.substring(name!.indexOf('.'));
  }
}
