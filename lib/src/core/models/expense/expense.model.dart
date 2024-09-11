import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expenseType.enum.dart';

class Expense {
  String title;
  TypeExpense type;
  double value;
  Category category;
  DateTime date;

  Expense({
    required this.title,
    required this.type,
    required this.value,
    required this.category,
    required this.date,
  });
}

