import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/login/controller/login.controller.dart';
import 'package:meus_gastos/src/shared/widgets/button_default.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginCtrl = LoginController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: loginCtrl.formLoginKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Entrar', style: titleStyle1),
              const SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: loginCtrl.emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Endereço de E-mail para logar',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => loginCtrl.validatorEmail(value),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: loginCtrl.passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => loginCtrl.validatorPassword(value),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'ENTRAR',
                onPressed: () => loginCtrl.login(context),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'REGISTRAR',
                onPressed: () => loginCtrl.toRegister(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
