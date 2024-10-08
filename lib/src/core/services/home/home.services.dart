import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/services/firebase/firebase_auth/firebase_auth.service.dart';
import 'package:meus_gastos/src/core/services/firebase/firebase_cloud/firebase_cloud.service.dart';

class HomeServices {
  Future<List<Category>> fetchCategories() async {
    return FirebaseCloudService.getCategories();
  }

  Future<List<Expense>> fetchExpenses() async {
    return FirebaseCloudService.getExpense();
  }

  Future<String?> logoutUser() async {
    return FirebaseAuthService.logout();
  }
}
