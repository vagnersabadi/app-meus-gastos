import 'package:flutter/material.dart';
import 'package:meus_gastos/src/core/models/category/category.model.dart';
import 'package:meus_gastos/src/core/routes/route.enum.dart';
import 'package:meus_gastos/src/core/services/home/home.services.dart';
import 'package:meus_gastos/src/core/services/storage/storage.service.dart';
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
        showCategoryAddEditPage(context, null);
        break;
      default:
        showCategoryAddEditPage(context, null);
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

  loadExpenses() {}

  void showCategoryAddEditPage(context, category) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const CategoryAddEditPage();
      },
    );
  }

  toLogin(BuildContext context) async {
    await StorageService.saveBool(SharedPreferencesKeys.isLoggedIn, false);

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteEnum.loginPage.name,
        (route) => false,
      );
    }
  }

  action(DismissDirection dir, BuildContext context, Category category) {
    print(dir);

    if (dir == DismissDirection.endToStart) {
      // deve remover da lista
    } else {
      showCategoryAddEditPage(context, category);
    }
  }
}
