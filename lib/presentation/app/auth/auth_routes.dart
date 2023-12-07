import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/auth/screens/auth_screen.dart';
import 'package:onco_connect/presentation/app/auth/screens/login_screen.dart';
import 'package:onco_connect/presentation/app/auth/screens/signup_screen.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

class AuthRoutes {
  const AuthRoutes._();

  static List<GetPage> getAll() => [
        GetPage(
          name: RouteName.authScreen,
          page: () => const AuthScreen(),
          transitionDuration: 550.milliseconds,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: RouteName.signupScreen,
          page: () => const SignUpScreen(),
          transitionDuration: 550.milliseconds,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.login,
          page: () => const LoginScreen(),
          transitionDuration: 550.milliseconds,
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
