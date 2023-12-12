import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/domain/entities/questionnaire_entity.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/home_constants.dart';
import 'package:onco_connect/presentation/app/questionnaire/controllers/questionnaire_controller.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/widgets/custom_appbar.dart';
import 'package:onco_connect/presentation/widgets/drawer.dart';
import 'package:onco_connect/presentation/widgets/primary_button.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/progress_indicator.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

import '../../../common/utils/temp_utils.dart';
import '../../theme/text_theme/custom_text_theme.dart';

class QuestionnaireResponseScreen extends StatefulWidget {
  const QuestionnaireResponseScreen({super.key});

  @override
  State<QuestionnaireResponseScreen> createState() =>
      _QuestionnaireResponseScreenState();
}

class _QuestionnaireResponseScreenState
    extends State<QuestionnaireResponseScreen> {
  late PageController pageController;
  late QuestionnaireController questionnaireController;
  bool dataloaded = false;

  @override
  void initState() {
    questionnaireController = Get.find<QuestionnaireController>();
    pageController = PageController();
    super.initState();
  }

  void _onPageChange(String option, QuestionnaireEntity? entity) {
    pageController.nextPage(duration: 1.seconds, curve: Curves.ease);
    questionnaireController.submit(option, entity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).extension<CustomColorTheme>()!.scaffoldBackground,
      appBar: CustomAppBar(
        title: HomeConstants.myOncoCheck,
      ),
      drawer: const MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LVSpacer(),
          Obx(() {
            return _buildProgressIndicator(
              totalCompleted: questionnaireController.progressNotifier.value,
              totalCount: questionnaireController.questions?.length ?? 1,
            );
          }),
          const XLVSpacer(),
          Expanded(
            child: Obx(() {
              return questionnaireController.questions != null
                  ? PrimaryContainer(
                      child: PageView.builder(
                        itemCount:
                            questionnaireController.questions?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        itemBuilder: (context, i) =>
                            _buildBody(questionnaireController.questions![i]),
                      ),
                    )
                  : Container();
            }),
          )
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({
    required int totalCompleted,
    required int totalCount,
  }) {
    return PrimaryContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomProgressIndicator(
            completeCount: totalCompleted,
            totalCount: totalCount,
          ),
          const MVSpacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$totalCompleted/$totalCount ${HomeConstants.questionAns}",
                  style: Theme.of(context).extension<CustomTextTheme>()!.bodyMm,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody(QuestionnaireEntity? entity) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildImage(entity?.photoUrl ?? TempUtils.imageUrl),
        const MVSpacer(),
        _buildQuestionnaireTitle(entity?.question ?? ""),
        const LVSpacer(),
        _buildOptionButtons(entity?.options ?? [], entity)
      ],
    );
  }

  Widget _buildQuestionnaireTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).extension<CustomTextTheme>()!.bodyLr,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButtons(
      List<String> options, QuestionnaireEntity? entity) {
    return Wrap(
      spacing: LayoutConstants.dimen_8,
      runSpacing: LayoutConstants.dimen_8,
      children: options
          .map(
            (String option) => PrimaryButton(
              onTap: () => _onPageChange(option, entity),
              label: option,
              labelStyle:
                  Theme.of(context).extension<CustomTextTheme>()!.bodyLmPrimary,
              backgroundColor: Theme.of(context)
                  .extension<CustomColorTheme>()!
                  .auxiliaryBgColor,
              suffixIcon: Icon(
                Icons.add_circle_outline,
                size: LayoutConstants.dimen_18,
                color: Theme.of(context)
                    .extension<CustomColorTheme>()!
                    .primaryColor,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Center(
        child: Container(
          height: LayoutConstants.dimen_196,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: LayoutConstants.dimen_16,
        ),
        child: Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color:
                Theme.of(context).extension<CustomColorTheme>()!.primaryColor,
            backgroundColor:
                Theme.of(context).extension<CustomColorTheme>()!.auxiliaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Padding(
        padding: EdgeInsets.symmetric(
          vertical: LayoutConstants.dimen_16,
        ),
        child: Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
