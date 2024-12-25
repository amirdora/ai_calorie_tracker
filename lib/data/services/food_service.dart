import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/food_item.dart';

class FoodService {
  final String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  final String _model = 'gemini-pro-vision';
  
  String get _apiKey => dotenv.env['GOOGLE_AI_API_KEY'] ?? '';

  Future<FoodItem> detectFoodAndCalories(String base64Image) async {
    if (_apiKey.isEmpty) {
      throw Exception('Google AI API key not found in environment variables');
    }

    final uri = Uri.parse('$_baseUrl/models/$_model:generateContent?key=$_apiKey');
    
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{
            'parts': [
              {
                'text': 'Identify the food in this picture and estimate the calories. Return JSON in format: {"name": "food name", "calories": 100, "protein": 10, "carbs": 20, "fat": 5}'
              },
              {
                'inline_data': {
                  'mime_type': 'image/jpeg',
                  'data': base64Image
                }
              }
            ]
          }]
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('API call failed with status: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      
      // Extract JSON from response
      final match = RegExp(r'\{.*\}').firstMatch(text);
      if (match == null) {
        throw Exception('No valid JSON found in response');
      }

      final foodData = jsonDecode(match.group(0)!);
      
      return FoodItem(
        name: foodData['name'],
        calories: foodData['calories'].toDouble(),
        protein: foodData['protein'].toDouble(),
        carbs: foodData['carbs'].toDouble(),
        fat: foodData['fat'].toDouble(),
        quantity: 100.0, // Default serving size
        timestamp: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to detect food: ${e.toString()}');
    }
  }
}