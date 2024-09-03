enum AppRouteEnum { loginPage, registerPage }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.loginPage:
        return "/login";
      case AppRouteEnum.registerPage:
        return "/register";
      default:
        return "/login_page";
    }
  }
}
