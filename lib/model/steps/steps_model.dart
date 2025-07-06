class StepModel {
  final int steps;
  final Duration duration;
  final double calories;
  final double distance;

  StepModel({
    required this.steps,
    required this.duration,
    required this.calories,
    required this.distance,
  });

  StepModel.initial()
      : steps = 0,
        duration = Duration.zero,
        calories = 0,
        distance = 0;
}
