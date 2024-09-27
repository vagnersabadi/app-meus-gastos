import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/login/login.model.dart';
import 'package:meus_gastos/src/core/models/user/user.model.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/services/login/login.service.dart';
import 'package:meus_gastos/src/core/services/storage/storage.service.dart';

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

      await _loginService.loginWithEmailAndPassword(email, password).then((LoginResult login) {
        if (context.mounted) {
          if (login.success) {
            StorageService.saveBool(SharedPreferencesKeys.isLoggedIn, true);
            User user = User(email: email, password: password);

            StorageService.saveString(SharedPreferencesKeys.userLogin, user.toJson());

            toHome(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(login.message ?? 'Erro ao realizar o login. Verifique seu dados.')),
            );
          }
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

  toHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteEnum.homePage.name,
      (route) => false,
    );
  }

  isLogin(context) async {
    var isLoggedIn = await StorageService.getBool(SharedPreferencesKeys.isLoggedIn);

    if (isLoggedIn != null && isLoggedIn && context.mounted) {
      toHome(context);
    }
  }
}
