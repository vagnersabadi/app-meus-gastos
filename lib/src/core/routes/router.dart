import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/src/features/category/view/category_add_edit.dart';
import 'package:meus_gastos/src/features/expenses/view/expenses_add.dart';
import 'package:meus_gastos/src/features/home/view/home.dart';
import 'package:meus_gastos/src/features/login/view/login.dart';
import 'package:meus_gastos/src/features/register/view/register.dart';

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
      case '/home':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const HomePage(),
        );
      case '/category-add':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const CategoryAddEditPage(),
        );
      case '/expense-add':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const ExpenseAddPage(),
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
