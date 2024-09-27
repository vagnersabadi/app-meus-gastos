// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/models/expense/expense.model.dart';
import 'package:meus_gastos/src/core/models/expense/expenseType.enum.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/services/firebase_cloud/firebase_cloud.service.dart';
import 'package:meus_gastos/src/core/services/home/home.services.dart';
import 'package:meus_gastos/src/core/services/storage/storage.service.dart';
import 'package:meus_gastos/src/features/category/view/category_add_edit.dart';
import 'package:meus_gastos/src/features/expenses/view/expenses_add.dart';

part 'home.state.dart';

class CardsDash {
  String input;
  String output;

  CardsDash({
    required this.input,
    required this.output,
  });
}

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(HomeInitial());

  final HomeServices homeServices = HomeServices();
  final CurrencyTextInputFormatter formatter =
      CurrencyTextInputFormatter.currency(locale: 'pt_BR', symbol: 'R\$');

  final StreamController<CardsDash> streamCtrl = StreamController<CardsDash>.broadcast();

  setState() {
    emit(state);
  }

  openAddEdit(index, BuildContext context) {
    switch (index) {
      case 0:
        showExpensesAddEditPage(context, expense: null);
        break;
      default:
        showCategoryAddEditPage(context, category: null);
    }
  }

  Future<void> loadCategories() async {
    emit(HomeLoading());

    try {
      final categories = await homeServices.fetchCategories();

      if (categories.isEmpty) {
        emit(HomeEmpty('Nenhuma categoria cadastrada'));
      } else {
        emit(HomeSuccess(categories));
      }
    } catch (e) {
      emit(HomeError('Não foi possível carregar a lista'));
    }
  }

  Future<void> loadExpenses() async {
    emit(HomeExpensesLoading());

    try {
      final expenses = await homeServices.fetchExpenses();

      if (expenses.isEmpty) {
        emit(HomeExpensesEmpty('Nenhum lançamento cadastrado'));
      } else {
        emit(HomeExpensesSuccess(expenses));
        cardsValue(expenses);
      }
    } catch (e) {
      emit(HomeExpensesError('Não foi possível carregar a lista'));
    }
  }

  cardsValue(List<Expense> expenses) {
    String totalOutput = expenses
        .where((expense) => expense.type == TypeExpense.output.name)
        .fold(0.0, (p, e) => p + double.parse(e.value))
        .toString();

    String totalInput = expenses
        .where((e) => e.type == TypeExpense.input.name)
        .fold(0.0, (p, e) => p + double.parse(e.value))
        .toString();

    CardsDash card = CardsDash(input: totalInput, output: totalOutput);
    streamCtrl.sink.add(card);
  }

  void showCategoryAddEditPage(BuildContext context, {Category? category}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (result != null && result == true) {
              loadCategories();
            }
          },
          child: CategoryAddEditPage(category: category),
        );
      },
    );
  }

  void showExpensesAddEditPage(BuildContext context, {Expense? expense}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: PopScope(
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (result != null && result == true) {
                  loadExpenses();
                }
              },
              child: ExpenseAddEditPage(expense: expense),
            ),
          );
        });
  }

  toLogin(BuildContext context) async {
    await StorageService.saveBool(SharedPreferencesKeys.isLoggedIn, false);
    await homeServices.logoutUser();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteEnum.loginPage.name,
        (route) => false,
      );
    }
  }

  Future<bool> actionCategory(
      DismissDirection dir, BuildContext context, Category category) async {
    if (dir == DismissDirection.endToStart) {
      FirebaseCloudService.removeCategory(category);
      return true;
    } else {
      showCategoryAddEditPage(context, category: category);
      return false;
    }
  }

  Future<bool> actionExpense(
      DismissDirection dir, BuildContext context, Expense expense) async {
    if (dir == DismissDirection.endToStart) {
      await FirebaseCloudService.removeExpense(expense);
      return true;
    } else {
      showExpensesAddEditPage(context, expense: expense);
      return false;
    }
  }

  String toCurrency(String value) {
    int v = int.parse(value);
    return NumberFormat('#,##0.00', 'pt_BR').format(v);
  }
}
