import 'package:flutter/material.dart';
import 'package:smart_quotes/screens/home_screen.dart';
import 'package:smart_quotes/screens/main_screen.dart';
import 'package:smart_quotes/screens/onboarding_screen.dart';
import 'package:smart_quotes/screens/splash_screen.dart';

const String SPLASH = '/splash';
const String ON_BOARDING = '/onboarding';
const String HOME = '/home';
const String MAIN = '/main';
const String FAST_FOOD_DETAIL = '/fastFoodDetail';
const String MENU_DETAIL = '/menuDetail';
const String LOGIN = '/login';
const String REGISTER = '/register';
const String LANDING = '/main';
const String AUTH = '/auth';
const String EDIT_PROFILE = '/editProfile';
const String ADDRESSES_LIST = '/addresses';
const String ORDER_DETAIL = '/orderDetailPage';
const String DELIVERY_DETAIL = '/deliveryDetailPage';
const String ORDERS_LIST = '/ordersList';
const String NEW_ADDRESS = '/newAddress';

Map<String, WidgetBuilder> appRoutes = {
  SPLASH: (context) => const SplashScreen(
        key: ValueKey("a"),
      ),
  ON_BOARDING: (context) => const OnboardingScreen(
        key: ValueKey("b"),
      ),
  HOME: (context) => const HomeScreen(
        key: ValueKey("c"),
      ),
  MAIN: (context) => const MainScreen(
        key: ValueKey("d"),
      ),
};
