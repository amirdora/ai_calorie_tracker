import 'package:ai_calorie_tracker/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/food_repository.dart';
import 'data/services/food_service.dart';
import 'presentation/cubit/food_log_cubit.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = !(prefs.getBool('onboarding_complete') ?? false);

  // Initialize services and repositories
  final foodService = FoodService();
  final foodRepository = FoodRepository(foodService, prefs);
  
  runApp(MyApp(
    showOnboarding: showOnboarding,
    foodRepository: foodRepository,
  ));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  final FoodRepository foodRepository;
  
  const MyApp({
    required this.showOnboarding,
    required this.foodRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodLogCubit(foodRepository),
      child: MaterialApp(
        title: 'Calorie Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: showOnboarding ? OnboardingScreen() : MainScreen(),
        routes: {
          '/main': (context) => MainScreen(),
          '/home': (context) => HomeScreen(), // Ensures `/home` route is defined
        },
      ),
    );
  }
}