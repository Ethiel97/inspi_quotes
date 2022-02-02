import 'package:flutter/material.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';
import 'package:smart_quotes/utils/app_router.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/local_storage.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<IntroScreen> pages = [
    IntroScreen(
      title: 'Votre inspiration',
      imageAsset: 'assets/img/1.png',
      description: "Des citations motivantes quotidiennes pour vous booster",
      headerBgColor: Colors.white,
      textStyle: textStyle,
    ),
    IntroScreen(
      title: "Votre Intellect",
      headerBgColor: Colors.white,
      imageAsset: 'assets/img/2.png',
      description: "Enrichissez vos connaissances avec de nouvelles citations",
      textStyle: textStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  goToNextPage() {
    LocalStorage.setIsFirstLaunch(false);
    Navigator.of(context).pushReplacementNamed(MAIN);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IntroScreens(
          footerBgColor: TinyColor(screenBackgroundColor).color,
          activeDotColor: Colors.white,
          inactiveDotColor: TinyColor(Colors.white).darken(25).color,
          footerRadius: 18.0,
          indicatorType: IndicatorType.CIRCLE,
          slides: pages,
          skipText: 'Passer',
          onDone: goToNextPage,
          onSkip: goToNextPage,
        ),
      );
}
