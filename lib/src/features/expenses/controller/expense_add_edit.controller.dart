import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/models/expense/expenseType.enum.dart';
import 'package:meus_gastos/src/core/services/firebase_cloud/firebase_cloud.service.dart';
import 'package:uuid/uuid.dart';

class ExpenseAddEditController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController value = TextEditingController();
  final TextEditingController date = TextEditingController();

  final CurrencyTextInputFormatter formatter =
      CurrencyTextInputFormatter.currency(locale: 'pt_BR', symbol: '', decimalDigits: 0);

  int segmentedType = 0;
  late Category category;

  Expense? expense;

  save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      TypeExpense type =
          segmentedType == 0 ? TypeExpense.input : TypeExpense.output;

      final String amount = value.text.replaceAll('.', '').replaceAll(',', '');

        if (expense != null) {
          Expense edited = Expense(
            id: expense!.id,
            title: title.text,
            type: type.name,
            category: category,
            date: date.text,
            value: amount,
          );
          FirebaseCloudService.editExpense(edited);
        } else {
          Expense newExpense = Expense(
            id: const Uuid().v1(),
            title: title.text,
            type: type.name,
            category: category,
            date: date.text,
            value: amount,
          );
          FirebaseCloudService.saveExpense(newExpense);
        }

        Navigator.pop(context, true);
    }
  }

  Future<List<Category>> fetchCategories() async {
    return await FirebaseCloudService.getCategories();
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

  String? validatorValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com texto válido';
    }
    return null;
  }

  String? validatorDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com uma data válido';
    }
    return null;
  }
}
