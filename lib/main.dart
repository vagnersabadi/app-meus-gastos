import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/router/router.dart';
import 'package:meus_gastos/src/features/login/presentation/login.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Gastos App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
