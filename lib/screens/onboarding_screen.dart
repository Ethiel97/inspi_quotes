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
      title: 'Daily boost',
      imageAsset: 'assets/img/1-dark.png',
      description: "Daily motivational quotes to boost you",
      headerBgColor: Colors.white,
      textStyle: textStyle,
    ),
    IntroScreen(
      title: "Intellect",
      headerBgColor: Colors.white,
      imageAsset: 'assets/img/2-dark.png',
      description: "Enrich your knowledge with new quotes",
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
    Navigator.of(context).pushReplacementNamed(landing);
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
          textColor: Colors.white,
          skipText: 'Passer',
          onDone: goToNextPage,
          onSkip: goToNextPage,
        ),
      );
}
