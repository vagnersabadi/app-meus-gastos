import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/features/login/models/login.model.dart';

class LoginController {
  late final Login user;
  final formLoginKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com email válido';
    }
    return null;
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com a senha válido';
    }
    return null;
  }

  login(BuildContext context) {
    if (formLoginKey.currentState!.validate()) {
      _loginFirebase(context);
    }
  }

  toRegister(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteEnum.registerPage.name,
      (route) => false,
    );
  }

  _toHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteEnum.homePage.name,
      (route) => false,
    );
  }

// https://kymoraa.medium.com/flutter-x-firebase-authentication-a54e7ab40790
  _loginFirebase(context) async {
    String email = emailCtrl.text;
    String password = passwordCtrl.text;

    final firebaseAuth = FirebaseAuth.instance;
    String message = '';

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      _toHome(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
