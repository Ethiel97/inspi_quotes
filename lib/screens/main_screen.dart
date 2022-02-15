import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/providers/theme_provider.dart';
import 'package:smart_quotes/screens/favorite_quotes_screen.dart';
import 'package:smart_quotes/screens/home_screen.dart';
import 'package:smart_quotes/screens/quotes_screen.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/text_styles.dart';

import 'search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late NavigationProvider _navigationProvider;
  late ThemeProvider _themeProvider;

  List<Widget> screens = [
    const QuotesScreen(key: ValueKey("quotes")),
    const SearchScreen(key: ValueKey("search")),
    const FavoriteQuotesScreen(key: ValueKey("fav_quotes")),
  ];

  List<BottomNavigationBarItem> navigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBold.home,
      ),
      backgroundColor: Colors.transparent,
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBold.search,
      ),
      backgroundColor: Colors.transparent,
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyBold.bookmark,
      ),
      backgroundColor: Colors.transparent,
      label: 'Saved',
    ),
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            // systemNavigationBarColor: Colors.blue, // navigation bar color
            statusBarColor: Theme.of(context).backgroundColor),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _themeProvider = Provider.of<ThemeProvider>(context);
  }

  void _onItemTapped(int index) {
    _navigationProvider.currentIndex = index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: screenBackgroundColor,
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0.0,
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24,
                top: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 9.w,
                    width: 9.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "d",
                      style: textStyle.apply(
                        color: Colors.white,
                        fontSizeDelta: 3,
                        fontWeightDelta: 5,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _themeProvider.toggleMode(),
                    icon: Icon(
                      _themeProvider.currentTheme == 'dark'
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      size: 8.w,
                    ),
                    color: Theme.of(context).iconTheme.color,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Center(
              child: screens.elementAt(_navigationProvider.currentIndex),
              /*child: IndexedStack(
                children: screens,
                index: _navigationProvider.currentIndex,
              ),*/
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).backgroundColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          iconSize: 24,
          items: navigationBarItems,
          currentIndex: _navigationProvider.currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          onTap: _onItemTapped,
        ),
      );
}
