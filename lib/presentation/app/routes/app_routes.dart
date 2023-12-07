import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/auth/auth_routes.dart';
import 'package:onco_connect/presentation/app/dashboard/dashboard_route.dart';
import 'package:onco_connect/presentation/app/launch/splash_route.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';

class AppRoutes {
  const AppRoutes._();
  static unknownRoute() => GetPage(
        name: RouteName.notFound,
        page: () => const Scaffold(
          body: Center(
            child: Text("NotFound"),
          ),
        ),
      );
  static appRoutes() => [
        ...SplashRoute.getAll(),
        ...AuthRoutes.getAll(),
        ...DashboardRoute.getAll(),
      ];
}
