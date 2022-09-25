import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

//sora
//epilogue
//oxygen
//work sans

var textStyle = GoogleFonts.workSans(
  fontSize: 17,
  fontWeight: FontWeight.normal,
  color: WidgetsBinding.instance.window.platformBrightness == Brightness.dark
      ? darkColor
      : Colors.white,
  decoration: TextDecoration.none,
);

var secondaryTextStyle = GoogleFonts.epilogue(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  decoration: TextDecoration.none,
);

var textStyleLight = textStyle.apply(
  fontWeightDelta: -3,
  decoration: TextDecoration.none,
);
