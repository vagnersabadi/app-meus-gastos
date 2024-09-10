import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController {
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

    final firebaseAuth = FirebaseAuth.instance;
    String message = '';

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário registrado com sucesso!')),
      );

       
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = 'Já existe uma conta com esse e-mail.';
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
