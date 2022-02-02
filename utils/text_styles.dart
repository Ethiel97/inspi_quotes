import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

var textStyle = GoogleFonts.nunitoSans(
  fontSize: 17,
  fontWeight: FontWeight.normal,
  color: darkColor,
);

var secondaryTextStyle = GoogleFonts.lato(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

var textStyleLight = textStyle.apply(
  fontWeightDelta: -2,
);
