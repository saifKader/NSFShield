import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:nsfsheild/presentation/screens/scan_screen.dart';
import 'package:sizing/sizing.dart';
import '../../utils/theme.dart';
import '../screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoSize;
  late Animation<double> _logoPosition;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds:2),
    );

    _logoSize = Tween<double>(begin: 300, end: AppSizes.khugeImageSize).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _backgroundColor = ColorTween(
      begin: Colors.blue,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().whenComplete(() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logoPosition = Tween<double>(
      begin: 0,
      end: -0.31.sh,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColor.value,
          body: Center(
            child: Transform.translate(
              offset: Offset(0, _logoPosition.value),
              child: Container(
                width: _logoSize.value,
                height: _logoSize.value,
                child: Image.asset('assets/images/logo.jpg'),
              ),
            ),
          ),
        );
      },
    );
  }
}
