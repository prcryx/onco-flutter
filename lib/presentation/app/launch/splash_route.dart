import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

import 'splash_screen.dart';

class SplashRoute {
  const SplashRoute._();

  static List<GetPage> getAll() {
    return [
      GetPage(
        name: RouteName.splashScreen,
        page: () => const SplashScreen(),
        transitionDuration: 250.milliseconds,
        transition: Transition.fadeIn,
      ),
    ];
  }
}
