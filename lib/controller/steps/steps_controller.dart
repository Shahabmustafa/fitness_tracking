import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import '../../model/steps/steps_model.dart';

final stepsProvider = StateNotifierProvider<StepsController, StepModel>(
      (ref) => StepsController(),
);


class StepsController extends StateNotifier<StepModel> {
  late Stream<StepCount> _stepStream;
  Timer? _timer;
  DateTime? _startTime;

  StepsController() : super(StepModel.initial()) {
    _initStepTracking();
  }

  void _initStepTracking() {
    _startTime = DateTime.now();

    _stepStream = Pedometer.stepCountStream;
    _stepStream.listen((event) {
      final steps = event.steps;
      final duration = DateTime.now().difference(_startTime!);
      final calories = steps * 0.04;
      final distance = steps * 0.0008;

      state = StepModel(
        steps: steps,
        duration: duration,
        calories: calories,
        distance: distance,
      );
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final updatedDuration = DateTime.now().difference(_startTime!);
      state = StepModel(
        steps: state.steps,
        duration: updatedDuration,
        calories: state.steps * 0.04,
        distance: state.steps * 0.0008,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
