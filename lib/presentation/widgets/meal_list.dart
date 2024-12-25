import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';
import '../../data/models/meal_detail_screen.dart';
import 'meal_list_item.dart';

class MealList extends StatelessWidget {
  final List<FoodItem> meals;

  const MealList({
    required this.meals,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailScreen(meal: meals[index]),
            ),
          );
        },
        child: MealListItem(meal: meals[index]),
      ),
    );
  }
}