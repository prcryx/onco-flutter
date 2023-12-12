import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/common/utils/temp_utils.dart';
import 'package:onco_connect/domain/entities/meta/meta_doc.dart';
import 'package:onco_connect/presentation/app/auth/controller/auth_controller.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/controllers/home_controller.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/home_constants.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/widgets/questionnaire_progress_card.dart';
import 'package:onco_connect/presentation/app/routes/routes_name.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/custom_appbar.dart';
import 'package:onco_connect/presentation/widgets/drawer.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/pull_to_refresh.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../common/constants/png_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthController authController;
  late HomeController homeController;
  late ScrollController scrollController;
  late RefreshController refreshController;
  @override
  void initState() {
    authController = Get.find<AuthController>();
    homeController = Get.find<HomeController>();
    scrollController = ScrollController();
    refreshController = RefreshController(initialRefresh: false);

    super.initState();
  }

  void _navigateToQuestionnaireRespScreen() {
    Get.toNamed(RouteName.questionnaireResponseScreen);
  }

  void _onRefresh() async {
    if (mounted) {
      authController.loadMetaData();
      refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.scaffoldBackground,
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        title: HomeConstants.myOncoCheck,
      ),
      resizeToAvoidBottomInset: false,
      body: PullToRefresh(
        onRefresh: _onRefresh,
        refreshController: refreshController,
        scrollController: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              const RVSpacer(),
              _buildCancerCellIcon(),
              const RVSpacer(),
              _buildTitle(),
              const RVSpacer(),
              Obx(() {
                return QuestionnaireProgressCard(
                  totalQuestions: authController.metaData.value.count ?? 1,
                  totalCompleted: authController
                          .userMetaData.value.questionnaireResponseCount ??
                      0,
                  imageUrl: homeController.firstQuestion.value.photoUrl ??
                      TempUtils.imageUrl,
                  onTap: _navigateToQuestionnaireRespScreen,
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutConstants.dimen_16),
            child: Text(
              HomeConstants.takeAsssessment,
              style: Theme.of(context).extension<CustomTextTheme>()!.headingLb,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancerCellIcon() {
    return PrimaryContainer(
      child: Row(
        children: [
          Image.asset(
            PngConstants.cancerCell,
            width: LayoutConstants.defaultSvgSize,
            height: LayoutConstants.defaultSvgSize,
          ),
        ],
      ),
    );
  }
}
