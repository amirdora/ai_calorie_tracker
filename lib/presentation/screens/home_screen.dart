import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/food_log_cubit.dart';
import '../widgets/daily_tracker.dart';
import '../widgets/meal_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FoodLogCubit>().loadDailyLog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's trackers",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 16),
                BlocBuilder<FoodLogCubit, FoodLogState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    
                    if (state.error != null) {
                      return Center(
                        child: Text(
                          state.error!,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        DailyTracker(
                          calories: state.totalCalories,
                          protein: state.totalProtein,
                          carbs: state.totalCarbs,
                          fat: state.totalFat,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Meals',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 16),
                        MealList(meals: state.meals),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/scan'),
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}