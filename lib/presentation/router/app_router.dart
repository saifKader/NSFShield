import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsfsheild/presentation/router/routes.dart';

import '../screens/login.dart';
import '../screens/main_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      default:
        return null;
    }
  }
}