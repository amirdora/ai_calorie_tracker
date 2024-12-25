import 'package:ai_calorie_tracker/presentation/widgets/macro_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DailyTracker extends StatelessWidget {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  const DailyTracker({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: calories / 2000, // Assuming 2000 is daily goal
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange),
                Text(
                  '${calories.toInt()} kcal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            progressColor: Colors.orange,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MacroIndicator(
                label: 'Protein',
                value: protein,
                goal: 90,
                color: Colors.green,
              ),
              MacroIndicator(
                label: 'Fats',
                value: fat,
                goal: 70,
                color: Colors.orange,
              ),
              MacroIndicator(
                label: 'Carbs',
                value: carbs,
                goal: 110,
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}