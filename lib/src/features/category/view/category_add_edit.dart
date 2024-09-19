import 'package:flutter/material.dart';

import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/theme/variables.dart';
import 'package:meus_gastos/src/features/category/controller/category_add_edit.contoller.dart';
import 'package:meus_gastos/src/shared/widgets/button_default.widget.dart';

class CategoryAddEditPage extends StatefulWidget {
  final Category? category;

  const CategoryAddEditPage({
    super.key,
    this.category,
  });

  @override
  State<CategoryAddEditPage> createState() => _CategoryAddEditPage();
}

class _CategoryAddEditPage extends State<CategoryAddEditPage> {
  CategoryAddEditController categoryCtrl = CategoryAddEditController();
  String title = 'Adicionar';
  bool submitName = false;
  bool submitDesc = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      categoryCtrl.category = widget.category;
      categoryCtrl.name.text = widget.category!.name;
      categoryCtrl.description.text = widget.category!.description;
    }

    categoryCtrl.name.addListener(() {
      setState(() {
        submitName = categoryCtrl.name.text.isNotEmpty;
      });
    });

    categoryCtrl.description.addListener(() {
      setState(() {
        submitDesc = categoryCtrl.description.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    categoryCtrl.name.dispose();
    categoryCtrl.description.dispose();
    super.dispose();
  }

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
            Text(
              widget.category != null ? 'Editar Categoria' : 'Adicionar Categoria',
              style: titleStyle2,
            ),
            const SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: categoryCtrl.name,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Nome da categoria',
                border: OutlineInputBorder(),
              ),
              validator: (value) => categoryCtrl.validatorTitle(value),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: categoryCtrl.description,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descrição da categoria',
                border: OutlineInputBorder(),
              ),
              validator: (value) => categoryCtrl.validatorDescription(value),
            ),
            const SizedBox(height: 40),
            ButtonDefault(
              text: 'SALVAR',
              disabled: !submitDesc || !submitName,
              onPressed: () => categoryCtrl.save(context),
            ),
            const SizedBox(height: 10),
            ButtonDefault(
              text: 'CANCELAR',
              onPressed: () => categoryCtrl.cancel(context),
            )
          ],
        ),
      ),
    );
  }
}
