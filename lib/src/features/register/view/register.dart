import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/register/controller/register.controller.dart';

import '../../../shared/widgets/button_default.widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerCtrl = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: registerCtrl.formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Registar',
                style: titleStyle1,
              ),
              const SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: registerCtrl.emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Endereço de E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: registerCtrl.passwordCtrl,
                validator: (value) => registerCtrl.validatorPassword(value),
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Crie sua Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: registerCtrl.confirmPasswordCtrl,
                validator: (value) => registerCtrl.validatorPassword(value),
                decoration: const InputDecoration(
                  labelText: 'Confirme sua Senha',
                  hintText: 'Confirme sua Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'REGISTRAR',
                onPressed: () => registerCtrl.register(context),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'CANCELAR',
                onPressed: () => {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteEnum.loginPage.name,
                    (route) => false,
                  )
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
