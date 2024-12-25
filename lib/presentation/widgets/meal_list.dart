import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';
import 'meal_list_item.dart';

class MealList extends StatelessWidget {
  final List<FoodItem> meals;

  const MealList({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) => MealListItem(meal: meals[index]),
    );
  }
}