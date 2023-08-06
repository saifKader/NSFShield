import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:nsfsheild/presentation/screens/scan_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  var _currentIndex = 0;

  final List<String> _titles = ['Home','Profile','Scan'];

  @override
  Widget build(BuildContext context) {
    const IconData messenger_outline_outlined = IconData(0xef42, fontFamily: 'MaterialIcons');
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width ;
    var screenHeight = screenSize.height;
    //var iconSize = screenWidth * 0.0697;
    var iconSize = screenWidth * 0.064;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                _titles[_currentIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              leading: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              actions: const [
                IconButton(
                  icon: Icon(
                    messenger_outline_outlined,
                    size: 24,
                    color: Colors.black,
                  ),
                  onPressed: null,
                ),
                SizedBox(width: 8),
                Icon(
                  FontAwesomeIcons.bell,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),  // add this line to disable swipe
        controller: _pageController,
        children: <Widget>[
          Container(child: Center(child: Text('Home'))),
          Container(child: Center(child: Text('Profile'))),
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
          color: Color(0xff003679), // your custom color
        ),
        child: InkWell( // for click effect
          onTap: () {
            _pageController.jumpToPage(2);
          },
          child: Row( // Row for placing icon and text side by side
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                _currentIndex == 2
                    ? Icons.document_scanner
                    : Icons.document_scanner_outlined,
                color: _currentIndex == 2
                    ? Colors.white
                    : Colors.white,
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
                padding:  EdgeInsets.only(top: screenHeight * 0.01),
                child: Icon(
                  index == 0
                  //isActive ? _selectedItem.icon : _unselectedItem.icon,
                      ? (isActive ? FluentIcons.home_12_filled : FluentIcons.home_12_regular)
                      : (isActive ? FontAwesomeIcons.solidCircleUser : FontAwesomeIcons.circleUser),
                  size: iconSize,
                  color: isActive ? Color(0xff003679) : Colors.grey,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                index == 0 ? 'Home' : 'Profile',
                style: TextStyle(
                  color: isActive ? Color(0xff003679) : Colors.grey,
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
          color: Colors.black.withOpacity(0.5),  // 50% black shadow
          offset: const Offset(0, 0.5),                  // Move shadow 4 pixels downwards
          blurRadius: 8,                         // Add 8 pixels blur radius
        ),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
