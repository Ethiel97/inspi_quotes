import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/utils/text_styles.dart';

import 'providers/connectivity_service.dart';
import 'screens/splash_screen.dart';
import 'utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Wifi,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConnectivityStatus connectivityStatus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    connectivityStatus = Provider.of<ConnectivityStatus>(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConnectivityService().notify(connectivityStatus);

    return Sizer(builder: (context, orientation, deviceType) {
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
}
