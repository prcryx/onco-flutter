import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/home_constants.dart';
import 'package:onco_connect/presentation/app/dashboard/pages/home/temp.constants.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/primary_container.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuestionnaireProgressCard extends StatefulWidget {
  final int totalQuestions;
  final int totalCompleted;
  const QuestionnaireProgressCard({
    super.key,
    required this.totalQuestions,
    required this.totalCompleted,
  });

  @override
  State<QuestionnaireProgressCard> createState() =>
      _QuestionnaireProgressCardState();
}

class _QuestionnaireProgressCardState extends State<QuestionnaireProgressCard> {
  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_8),
        child: Container(
          padding: const EdgeInsets.only(top: LayoutConstants.dimen_16),
          color:
              Theme.of(context).extension<CustomColorTheme>()!.auxiliaryBgColor,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildQuestionnaireTitle(),
                const RVSpacer(),
                _buildProgressIndicator(
                    widget.totalCompleted, widget.totalQuestions),
                const RVSpacer(),
                CachedNetworkImage(
                  imageUrl: Temp.imageUrl,
                  imageBuilder: (context, imageProvider) => Center(
                    child: Container(
                      height: LayoutConstants.dimen_196,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: LayoutConstants.dimen_16,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
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
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildQuestionnaireTitle() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutConstants.dimen_16),
            child: Text(
              HomeConstants.completeQuestionnaire,
              style: Theme.of(context).extension<CustomTextTheme>()!.bodyLb,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(int completeCount, int totalCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearPercentIndicator(
            lineHeight: LayoutConstants.dimen_8,
            percent: completeCount / totalCount,
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(LayoutConstants.dimen_4),
            backgroundColor:
                Theme.of(context).extension<CustomColorTheme>()!.auxiliaryColor,
            progressColor:
                Theme.of(context).extension<CustomColorTheme>()!.primaryColor!,
          ),
          const MVSpacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$completeCount/$totalCount ${HomeConstants.questionAns}",
                  style: Theme.of(context).extension<CustomTextTheme>()!.bodyMm,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
