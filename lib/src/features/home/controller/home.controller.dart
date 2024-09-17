import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/services/home/home.services.dart';
import 'package:meus_gastos/src/features/category/view/category_add_edit.dart';
import 'package:bloc/bloc.dart';

part 'home.state.dart';

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(HomeInitial());

  final HomeServices homeServices = HomeServices();

  setState() {
    emit(state);
  }

  openAddEdit(index, BuildContext context) {
    switch (index) {
      case 0:
        showCategoryAddEditPage(context);
        break;
      default:
        showCategoryAddEditPage(context);
    }
  }

  Future<void> loadCategories() async {
    emit(HomeLoading());

    try {
      final categories = await homeServices.fetchCategories();
      emit(HomeSuccess(categories));
    } catch (e) {
      emit(HomeError('Não foi possível carregar a lista'));
    }
  }

  loadExpenses() {}

  void showCategoryAddEditPage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const CategoryAddEditPage();
      },
    );
  }

  toLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteEnum.loginPage.name,
      (route) => false,
    );
  }

  action(DismissDirection dir, context) {
    print(dir);

    if (dir == DismissDirection.endToStart) {
      // deve remover da lista
    } else {
      // deve abrir o editar
      showCategoryAddEditPage(context);
    }
  }
}
