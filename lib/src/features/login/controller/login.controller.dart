import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/login/login.model.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/services/login/login.service.dart';

class LoginController {
  final LoginService _loginService = LoginService();
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

  login(BuildContext context) async {
    if (formLoginKey.currentState!.validate()) {
      String email = emailCtrl.text;
      String password = passwordCtrl.text;
      String message = '';

      await _loginService.loginWithEmailAndPassword(email, password).then((LoginResult login) {
        if (login.success) {
          _toHome(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      });
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
}
