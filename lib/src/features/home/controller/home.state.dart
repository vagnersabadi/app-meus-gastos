part of 'home.controller.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<Category> categories;

  HomeSuccess(this.categories);
}

class HomeError extends HomeStates {
  final String error;

  HomeError(this.error);
}

class HomeEmpty extends HomeStates {
  final String msg;

  HomeEmpty(this.msg);
}


abstract class HomeExpensesStates {}

class HomeExpensesInitial extends HomeExpensesStates {}

class HomeExpensesLoading extends HomeExpensesStates {}

class HomeExpensesSuccess extends HomeExpensesStates {
  final List<dynamic> expenses;

  HomeExpensesSuccess(this.expenses);
}

class HomeExpensesError extends HomeExpensesStates {
  final String error;

  HomeExpensesError(this.error);
}

class HomeExpensesEmpty extends HomeExpensesStates {
  final String msg;

  HomeExpensesEmpty(this.msg);
}
