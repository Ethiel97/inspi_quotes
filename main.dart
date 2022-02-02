import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/utils/text_styles.dart';

import 'screens/splash_screen.dart';
import 'utils/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      Sizer(builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Inspi Quotes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: textStyle.fontFamily,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: appRoutes,
          home: const SplashScreen(
            key: ValueKey("spash"),
          ),
        );
      });
}
