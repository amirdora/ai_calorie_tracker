import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';
import '../services/food_service.dart';

class FoodRepository {
  final FoodService _foodService;
  final SharedPreferences _prefs;
  
  FoodRepository(this._foodService, this._prefs);

  Future<List<FoodItem>> getDailyFoodLog(DateTime date) async {
    final String key = 'food_log_${date.toIso8601String().split('T')[0]}';
    final String? storedData = _prefs.getString(key);
    
    if (storedData != null) {
      final List<dynamic> jsonList = json.decode(storedData);
      return jsonList.map((json) => FoodItem.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> addFoodItem(FoodItem item) async {
    final String key = 'food_log_${item.timestamp.toIso8601String().split('T')[0]}';
    List<FoodItem> currentLog = await getDailyFoodLog(item.timestamp);
    currentLog.add(item);
    
    await _prefs.setString(
      key,
      json.encode(currentLog.map((item) => item.toJson()).toList()),
    );
  }

  Future<FoodItem> detectFoodFromImage(String base64Image) async {
    return await _foodService.detectFoodAndCalories(base64Image);
  }
}