import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/dashboard/controller/dashboard_bindings.dart';
import 'package:onco_connect/presentation/app/dashboard/dashboard_screen.dart';

import '../routes/routes_name.dart';

class DashboardRoute {
  const DashboardRoute._();

  static List<GetPage> getAll() {
    return [
      GetPage(
        name: RouteName.dashboardScreen,
        page: () => const DashboardScreen(),
        transitionDuration: 250.milliseconds,
        transition: Transition.fadeIn,
        binding: DashboardBindings(),
      ),
    ];
  }
}
