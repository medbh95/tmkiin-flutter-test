import 'package:get/get.dart';
import 'package:tmkiin_test/bindings/home_screen_bindings.dart';
import 'package:tmkiin_test/bindings/login_bindings.dart';
import 'package:tmkiin_test/bindings/register_bindings.dart';
import 'package:tmkiin_test/view/login_screen.dart';
import 'package:tmkiin_test/view/main_view.dart';
import 'package:tmkiin_test/view/register_screen.dart';

class RouteConstant {
  static const String homeScreen = '/home';
}

appRoutes() => [
      GetPage(
          name: '/home',
          page: () => LoginScreen(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 100),
          binding: LoginScreenBinding()),
      GetPage(
          name: '/register',
          page: () => RegisterScreen(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 100),
          binding: RegisterScreenBinding()),
      GetPage(
          name: '/main',
          page: () => MainView(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 100),
          binding: HomeScreenBinding()),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
