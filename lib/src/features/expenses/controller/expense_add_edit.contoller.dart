import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/services/firebase_cloud/firebase_cloud.service.dart';
import 'package:uuid/uuid.dart';

class ExpenseAddEditController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController value = TextEditingController();
  final TextEditingController date = TextEditingController();

  Expense? expense;

  save(BuildContext context) {
    if (formKey.currentState!.validate()) {
    //   if (expense != null) {
    //     Expense categoryEdited = Expense(
    //     //   id: expense!.id,
    //     //   name: name.text,
    //     //   description: description.text,
    //     );
    //     // FirebaseCloudService.editExpense(categoryEdited);
    //   } else {
    //     Expense expense = Expense(
    //     //   id: const Uuid().v1(),
    //     //   name: name.text,
    //     //   description: description.text,
    //     );
    //     // FirebaseCloudService.saveExpense(category);
    //   }

      Navigator.pop(context, true);
    }
  }

  cancel(context) {
    Navigator.pop(context, false);
  }

  String? validatorTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com texto válido';
    }
    return null;
  }

  String? validatorDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com texto válido';
    }
    return null;
  }
}
