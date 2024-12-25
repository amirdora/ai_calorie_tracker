import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/food_item.dart';

class MealDetailScreen extends StatelessWidget {
  final FoodItem meal;

  const MealDetailScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.name,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (meal.imageUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    meal.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DetailListItem(
              icon: Icons.local_fire_department,
              label: 'Calories',
              value: '${meal.calories.toStringAsFixed(1)} kcal',
            ),
            DetailListItem(
              icon: Icons.fitness_center,
              label: 'Protein',
              value: '${meal.protein.toStringAsFixed(1)} g',
            ),
            DetailListItem(
              icon: Icons.grain,
              label: 'Carbs',
              value: '${meal.carbs.toStringAsFixed(1)} g',
            ),
            DetailListItem(
              icon: Icons.oil_barrel,
              label: 'Fat',
              value: '${meal.fat.toStringAsFixed(1)} g',
            ),
            DetailListItem(
              icon: Icons.scale,
              label: 'Quantity',
              value: '${meal.quantity.toStringAsFixed(1)} g',
            ),
            DetailListItem(
              icon: Icons.calendar_today,
              label: 'Logged on',
              value: '${meal.timestamp.toLocal()}',
            ),
          ],
        ),
      ),
    );
  }
}

class DetailListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailListItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}