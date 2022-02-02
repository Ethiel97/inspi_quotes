import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

//const primaryColor = Color(0xff3A86FF);
//const primaryColor = Color(0xff414324);
//const baseColor = Color(0xff3F88C5);
//const baseColor = Color(0xff1479ff);
const baseColor = Color(0xff0890DB);
var primaryColor = TinyColor(baseColor).color;

//var color = TinyColor(primaryColor).shade()
var primaryColorDark = TinyColor(baseColor).darken().color;

const secondaryColor = Color(0xffD72638);
//const secondaryColor = Color(0xffff7854);
// var secondaryColor = Color(0xff7F7FD5);
var thirdColor = Color(0xffF49D37);

var fourthColor = Color(0xff49bf43);

var fifthColor = Color(0xffa584ff);

var darkColor = Color(0xff140F2D);

//var screenBackgroundColor = Color(0xfff2f3f8);
//var screenBackgroundColor = Color(0xfff9f8f8);
var screenBackgroundColor = const Color(0xff060606);
var whiteBackgroundColor = Colors.white;

var accentColor = Color(0xff703539);

List<Color> colors = [
  Color.fromRGBO(241, 122, 59, 0.91),
  Color.fromRGBO(249, 224, 196, 1),
  Color(0xff654ea3),
  Color(0xffeaafc8),
  Color(0xff00B4DB),
  Color(0xff0083B0),
  Color(0xff283c86),
  Color(0xff45a247),
  Color(0xffec2F4B),
  Color(0xff009FFF),
  Color(0xffFF4B2B),
  Color(0xffFDC830),
  Color(0xfffc00ff),
  Color(0xff00dbde),
  Color(0xff667db6),
  Color(0xff30E8BF),
  Color(0xffFEAC5E),
  Color(0xffC779D0),
  Color(0xff4BC0C8),
  Color(0xff0082c8),
  Color(0xff0072ff),
  Color(0xff24C6DC),
  Color(0xff4A569D),
  Color(0xff0072ff),
  Color(0xffDC2424),
//  Colors.blueGrey,
//  primaryColor,
//  secondaryColor,
//  darkColor,
//  secondaryAccentColor,
//  Colors.amber,
//  Colors.orange,
//  Colors.indigo
];
