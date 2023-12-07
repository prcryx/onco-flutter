import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IDashboardController {
  void onPageChange(int nextPage, int currentPage);
  int get currentIndex;

  PageController get pageController;
}

class DashboardController extends GetxController
    implements IDashboardController {
  RxInt prevPageIndex = 0.obs;
  RxInt currentPageIndex = 0.obs;

  PageController pgCtrlr = PageController();

  @override
  void onPageChange(int nextPage, int currentPage) {
    currentPageIndex.value = nextPage;
    prevPageIndex.value = currentPage;
    pgCtrlr.jumpToPage(currentPageIndex.value);
  }

  @override
  int get currentIndex => currentPageIndex.value;

  @override
  PageController get pageController => pgCtrlr;
}
