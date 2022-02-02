import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_quotes/providers/navigation_provider.dart';
import 'package:smart_quotes/screens/home_screen.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/text_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late NavigationProvider _navigationProvider;

  List<Widget> screens = [
    const HomeScreen(key: ValueKey("home")),
    const HomeScreen(key: ValueKey("home")),
    const HomeScreen(key: ValueKey("home")),
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigationProvider = Provider.of<NavigationProvider>(context);
  }

  void _onItemTapped(int index) {
    _navigationProvider.currentIndex = index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: screenBackgroundColor,
        body: Center(
          child: screens.elementAt(
            _navigationProvider.currentIndex,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: screenBackgroundColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          iconSize: 24,
          items: navigationBarItems,
          currentIndex: _navigationProvider.currentIndex,
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      );
}
