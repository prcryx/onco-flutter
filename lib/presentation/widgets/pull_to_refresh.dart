import 'package:flutter/material.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefresh extends StatelessWidget {
  final VoidCallback onRefresh;
  final Widget child;
  final RefreshController refreshController;
  final ScrollController? scrollController;
  const PullToRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    required this.refreshController,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: ClassicHeader(
        textStyle: Theme.of(context).extension<CustomTextTheme>()!.bodyMrHint!,
        refreshingIcon: CircularProgressIndicator(
          color: Theme.of(context).extension<CustomColorTheme>()!.primaryColor,
        ),
      ),
      scrollController: scrollController,
      controller: refreshController,
      enablePullDown: true,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
