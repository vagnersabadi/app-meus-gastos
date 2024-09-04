enum AppRouteEnum { loginPage, registerPage, categoryPage }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.loginPage:
        return "/login";
      case AppRouteEnum.registerPage:
        return "/register";
      case AppRouteEnum.categoryPage:
        return "/category";
      default:
        return "/login";
    }
  }
}
