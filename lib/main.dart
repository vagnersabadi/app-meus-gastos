import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/routes/router.dart';
import 'package:meus_gastos/src/features/login/view/login.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  
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
