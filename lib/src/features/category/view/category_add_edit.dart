import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/category/controller/category_add_edit.contoller.dart';
import 'package:meus_gastos/src/shared/widgets/button_default.widget.dart';

class CategoryAddEditPage extends StatefulWidget {
  const CategoryAddEditPage({super.key});

  @override
  State<CategoryAddEditPage> createState() => _CategoryAddEditPage();
}

class _CategoryAddEditPage extends State<CategoryAddEditPage> {

CategoryAddEditController categoryCtrl = CategoryAddEditController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: categoryCtrl.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Adicionar Categoria', style: titleStyle2),
              const SizedBox(height: 50),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: categoryCtrl.name,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Nome da categoria',
                  border: OutlineInputBorder(),
                ),
                // validator: (value) => loginCtrl.validatorEmail(value),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: categoryCtrl.description,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Descrição da categoria',
                  border: OutlineInputBorder(),
                ),
                // validator: (value) => loginCtrl.validatorPassword(value),
              ),
              const SizedBox(height: 40),
              ButtonDefault(
                text: 'SALVAR',
                onPressed: () => categoryCtrl.save(),
              ),
              const SizedBox(height: 10),
              ButtonDefault(
                text: 'CANCELAR',
                onPressed: () => categoryCtrl.cancel(),
              )
            ],
          ),
        ),
      );
  }
}
