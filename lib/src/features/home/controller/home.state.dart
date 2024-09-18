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
