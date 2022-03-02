import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';
import 'package:smart_quotes/utils/app_router.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/local_storage.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<IntroScreen> pages = [
    IntroScreen(
      title: AppLocalizations.of(Get.context!)!.daily_boost,
      imageAsset: 'assets/img/1-dark.png',
      description: AppLocalizations.of(Get.context!)!.quotes_to_boost_you,
      headerBgColor: Colors.white,
      textStyle: textStyle,
    ),
    IntroScreen(
      title: AppLocalizations.of(Get.context!)!.intellect,
      headerBgColor: Colors.white,
      imageAsset: 'assets/img/2-dark.png',
      description: AppLocalizations.of(Get.context!)!.enrich_knowledge,
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
          skipText: AppLocalizations.of(context)!.skip,
          onDone: goToNextPage,
          onSkip: goToNextPage,
        ),
      );
}
