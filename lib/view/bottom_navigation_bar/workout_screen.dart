import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutListScreen extends StatelessWidget {
  final List<Workout> workouts;

  const WorkoutListScreen({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Workouts')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return WorkoutCard(workout: workout);
        },
      ),
    );
  }
}


class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('MMM d, yyyy').format(workout.date);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.type,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "📅 $dateFormatted",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorkoutInfoChip(icon: Icons.timer, label: '${workout.durationMin} min'),
                WorkoutInfoChip(icon: Icons.directions_run, label: '${workout.distanceKm} km'),
                WorkoutInfoChip(icon: Icons.local_fire_department, label: '${workout.calories} cal'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const WorkoutInfoChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.deepPurple),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}




class Workout {
  final String id;
  final String userId;
  final String type;
  final int durationMin;
  final double distanceKm;
  final int calories;
  final DateTime date;
  final DateTime createdAt;

  Workout({
    required this.id,
    required this.userId,
    required this.type,
    required this.durationMin,
    required this.distanceKm,
    required this.calories,
    required this.date,
    required this.createdAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      durationMin: json['duration_min'],
      distanceKm: (json['distance_km'] as num).toDouble(),
      calories: json['calories'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
