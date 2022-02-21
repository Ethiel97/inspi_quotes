import 'package:flutter/material.dart';
import 'package:smart_quotes/screens/home_screen.dart';
import 'package:smart_quotes/screens/main_screen.dart';
import 'package:smart_quotes/screens/onboarding_screen.dart';
import 'package:smart_quotes/screens/splash_screen.dart';

const String splash = '/splash';
const String onBoarding = '/onboarding';
const String home = '/home';
const String login = '/login';
const String register = '/register';
const String landing = '/main';
const String auth = '/auth';

Map<String, WidgetBuilder> appRoutes = {
  splash: (context) => const SplashScreen(
        key: ValueKey("a"),
      ),
  onBoarding: (context) => const OnboardingScreen(
        key: ValueKey("b"),
      ),
  home: (context) => const HomeScreen(
        key: ValueKey("c"),
      ),
  landing: (context) => const MainScreen(
        key: ValueKey("d"),
      ),
};
