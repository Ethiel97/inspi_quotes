import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
import 'models/author.dart';
import 'models/quote.dart';
import 'models/tag.dart';
import 'providers/connectivity_service.dart';
import 'screens/splash_screen.dart';
import 'utils/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var quotesBox = 'quotes';
var authorsBox = 'authors';
var tagsBox = 'tags';

void initHiveBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(AuthorAdapter());
  await Hive.openBox<Quote>(quotesBox);
  await Hive.openBox<Author>(authorsBox);
  await Hive.openBox<Tag>(tagsBox);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initHiveBox();
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.wifi,
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

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
          title: 'Inspi Quotes',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          routes: appRoutes,
          home: const SplashScreen(
            key: ValueKey("spash"),
          ),
        ),
      ),
    );
  }
}
