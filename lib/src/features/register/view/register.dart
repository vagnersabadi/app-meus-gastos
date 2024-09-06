import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/router/route.enum.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';

import '../../../shared/widgets/button_default.widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final formRegisterKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formRegisterKey,
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
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Endereço de E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Crie sua Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirme sua Senha',
                  hintText: 'Confirme sua Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 60),
              ButtonDefault(
                text: 'REGISTRAR',
                onPressed: () => {},
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
