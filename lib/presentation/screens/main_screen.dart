import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:nsfsheild/presentation/screens/profile_screen.dart';
import 'package:nsfsheild/presentation/screens/scan_screen.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  var _currentIndex = 0;

  final List<String> _titles = ['Home', 'Profile', 'Scan'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const IconData messenger_outline_outlined =
        IconData(0xef42, fontFamily: 'MaterialIcons');
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    //var iconSize = screenWidth * 0.0697;
    var iconSize = screenWidth * 0.062;
    return Scaffold(
      appBar: AppBar(
        shape: _currentIndex == 0 || _currentIndex == 1 ? null : const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leadingWidth: screenWidth * 0.35,
        leading: InkWell(
          onTap: () {
            // Functionality for logo click, if required
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            // reduced horizontal padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35, // Slightly reduced the width
                  height: 35, // Slightly reduced the height
                  child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                ),
                const SizedBox(width: 5), // Reduced the width
                const Text(
                  'NSFShield',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const IconButton(
              icon: Icon(
                Icons.notifications,
                size: 24,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        // add this line to disable swipe
        controller: _pageController,
        children: <Widget>[
          HomeScreen(),
          ProfileScreen(),
          ScanScreen(),
        ],
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      floatingActionButton: Container(
        height: 60.0, // same height as FloatingActionButton
        width: 80.0, // double width for showing text
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0), // half of height and width
          color: theme.colorScheme.secondary, // your custom color
        ),
        child: InkWell(
          // for click effect
          onTap: () {
            _pageController.jumpToPage(2);
          },
          child: Row(
            // Row for placing icon and text side by side
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                _currentIndex == 2
                    ? Icons.document_scanner
                    : Icons.document_scanner_outlined,
                color: _currentIndex == 2 ? Colors.white : Colors.white,
                //mediaquery size
                size: iconSize,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 2,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.01),
                child: Icon(
                  index == 0
                      //isActive ? _selectedItem.icon : _unselectedItem.icon,
                      ? (isActive
                          ? FluentIcons.home_12_filled
                          : FluentIcons.home_12_regular)
                      : (isActive
                          ? FontAwesomeIcons.solidCircleUser
                          : FontAwesomeIcons.circleUser),
                  size: iconSize,
                  color: isActive ? theme.colorScheme.secondary : Colors.grey,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                index == 0 ? 'Home' : 'Profile',
                style: TextStyle(
                  color: isActive ? theme.colorScheme.secondary : Colors.grey,
                  fontSize: screenHeight * 0.013,
                ),
              ),
            ],
          );
        },
        backgroundColor: Colors.grey[350],
        activeIndex: _currentIndex,
        splashColor: Theme.of(context).primaryColor,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        shadow: Shadow(
          color: Colors.black.withOpacity(0.5), // 50% black shadow
          offset: const Offset(0, 0.5), // Move shadow 4 pixels downwards
          blurRadius: 8, // Add 8 pixels blur radius
        ),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
