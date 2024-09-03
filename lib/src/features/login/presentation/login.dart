import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/router/route.enum.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

import '../../../shared/widgets/button_default.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formLoginKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formLoginKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Entrar',
                style: titleStyle1,
              ),
              const SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Endereço de E-mail para logar',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'ENTRAR',
                onPressed: () => {},
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'REGISTRAR',
                onPressed: () => {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteEnum.registerPage.name,
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
