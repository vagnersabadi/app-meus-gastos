part of 'home_expenses.state.dart';

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
