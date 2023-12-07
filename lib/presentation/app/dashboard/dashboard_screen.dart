import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/presentation/app/dashboard/controller/dashboard_controller.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/articles/articles_screen.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/dairy/dairy_screen.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/service/services.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/tracks/tracks.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/widgets/bottom_nav_view.dart';
import 'package:onco_connect/presentation/widgets/buttom_nav_button.dart';

import '../../../common/constants/layout_constant.dart';
import 'dashboard_constants.dart';
import 'pages/home/home_screen.dart';

// class DashboardArgs {
//   final int openTab;
//   const DashboardArgs(this.openTab);
// }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardController dashboardController;

  @override
  void initState() {
    dashboardController = Get.find<DashboardController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  LayoutBuilder _buildBody() => LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildPages(),
            _buildBottomNavigation(constraints),
          ],
        ),
      );

  Widget _buildPages() => GetBuilder<DashboardController>(
      init: Get.find<DashboardController>(),
      builder: (IDashboardController controller) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: _dashboardPages,
        );
      });

  List<Widget> get _dashboardPages => [
        const HomeScreen(),
        const DairyScreen(),
        const ServicesPage(),
        const TrackScreen(),
        const ArticlesScreen(),
      ];

  Widget _buildBottomNavigation(BoxConstraints constraints) =>
      BottomNavigationView(
        color: Theme.of(context)
            .extension<CustomColorTheme>()!
            .complementaryColor!,
        width: constraints.maxWidth,
        height: LayoutConstants.dimen_76,
        children: _bottomNavigationButtons,
      );

  List<BottomNavigationButton> get _bottomNavigationButtons => [
        _buildBottomNavigationButton(
          DashboardConstants.home,
          DashboardConstants.home,
          Icons.home_outlined,
        ),
        _buildBottomNavigationButton(
          DashboardConstants.dairy,
          DashboardConstants.dairy,
          Icons.collections_bookmark_outlined,
        ),
        _buildBottomNavigationButton(
          DashboardConstants.services,
          DashboardConstants.services,
          Icons.medical_services_outlined,
        ),
        _buildBottomNavigationButton(
          DashboardConstants.track,
          DashboardConstants.track,
          Icons.send_outlined,
        ),
        _buildBottomNavigationButton(
          DashboardConstants.articles,
          DashboardConstants.articles,
          Icons.article_outlined,
        ),
      ];

  BottomNavigationButton _buildBottomNavigationButton(
    String pageAddr,
    String title,
    IconData icon,
  ) {
    return BottomNavigationButton(
      controller: dashboardController,
      icon: icon,
      uniqueIndex: DashboardConstants.pageAddress[pageAddr]!,
      title: title,
    );
  }
}
