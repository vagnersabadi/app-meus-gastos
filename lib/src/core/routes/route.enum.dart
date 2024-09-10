enum AppRouteEnum {
  loginPage,
  registerPage,
  homePage,
  categoryAddPage,
  expenseAddPage,
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.loginPage:
        return "/login";
      case AppRouteEnum.registerPage:
        return "/register";
      case AppRouteEnum.homePage:
        return "/home";
      case AppRouteEnum.categoryAddPage:
        return "/category-add";
      case AppRouteEnum.expenseAddPage:
        return "/expense-add";
      default:
        return "/login";
    }
  }
}
