import 'package:flutter/material.dart';

class StepProgressNotifier {
  ValueNotifier<int> _currentStepNotifier = ValueNotifier(0);
  void increment({int? step}) {
    _currentStepNotifier.value++;
  }

  int get step => _currentStepNotifier.value;
}
