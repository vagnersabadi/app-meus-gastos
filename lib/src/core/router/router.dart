import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/src/features/category/presentation/category.dart';
import 'package:meus_gastos/src/features/login/presentation/login.dart';
import 'package:meus_gastos/src/features/register/presentation/register.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/login";

    switch (settings.name) {
      case '/login':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LoginPage(),
        );
      case '/register':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const RegisterPage(),
        );
      case '/category':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const CategoryPage(),
        );
      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No found for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
