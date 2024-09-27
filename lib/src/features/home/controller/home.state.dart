part of 'home.controller.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<Category> categories;

  HomeSuccess(
    this.categories,
  );
}

class HomeError extends HomeStates {
  final String error;

  HomeError(this.error);
}

class HomeEmpty extends HomeStates {
  final String msg;

  HomeEmpty(this.msg);
}

class HomeExpensesInitial extends HomeStates {}

class HomeExpensesLoading extends HomeStates {}

class HomeExpensesSuccess extends HomeStates {
  final List<Expense> expenses;

  HomeExpensesSuccess(this.expenses);
}

class HomeExpensesError extends HomeStates {
  final String error;

  HomeExpensesError(this.error);
}

class HomeExpensesEmpty extends HomeStates {
  final String msg;

  HomeExpensesEmpty(this.msg);
}
