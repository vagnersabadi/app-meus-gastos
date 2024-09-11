import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/login/login.model.dart';
import 'package:meus_gastos/src/core/services/login/login.service.dart';

class RegisterController {
  final LoginService _loginService = LoginService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com a senha válido';
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      return 'As senhas não são iguais';
    }

    return null;
  }

  register(context) async {
    String email = emailCtrl.text;
    String password = passwordCtrl.text;
    String message = '';

    await _loginService.createLoginWithEmailAndPassword(email, password).then((LoginResult login) {
      if (login.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });

  }
}
