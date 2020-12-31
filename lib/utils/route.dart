
import 'package:flutter/cupertino.dart';
import 'package:sambatin/mvp/view/view.dart';
import 'package:sambatin/page/form_aduan_page.dart';
import 'package:sambatin/page/home_page.dart';
import 'package:sambatin/page/sign_in_page.dart';

class NavigateName {
  NavigateName._();
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const form_aduan = '/form-aduan';
}

Widget makeRoute(
    {@required BuildContext context,
    @required String routeName,
    Object arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute({
  @required BuildContext context,
  @required String routeName,
  Object arguments,
}) {
  switch (routeName) {
    case NavigateName.login:
      return LoginPage();
    case NavigateName.home:
      return HomePage();
    case NavigateName.form_aduan:
      return FormAduanPage();
    default:
      throw 'Route $routeName is not defined';
  }
}
