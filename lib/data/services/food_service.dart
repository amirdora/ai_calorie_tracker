import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../models/food_item.dart';

class FoodService {
  final String _model = 'gemini-1.5-pro';

  // Load the API key from the environment
  String get _apiKey => dotenv.env['GOOGLE_AI_API_KEY'] ?? '';

  // Initialize Gemini in the constructor
  FoodService() {
    if (_apiKey.isEmpty) {
      throw Exception('Google AI API key not found in environment variables');
    }

    // Initialize the Gemini instance
    Gemini.init(apiKey: _apiKey);
  }
Future<FoodItem> detectFoodAndCalories(File imageFile) async {
  try {
    // Ensure the file exists
    if (!imageFile.existsSync()) {
      throw Exception('File not found: ${imageFile.path}');
    }

    // Process text and image input
    final response = await Gemini.instance.textAndImage(
      text: 'Analyze this image and identify the food. '
          'Estimate its calories, protein, carbs, and fat. '
          'Return JSON in this format: {"name": "food name", "calories": 100, "protein": 10, "carbs": 20, "fat": 5}',
      images: [imageFile.readAsBytesSync()],
    );

    // Extract the output text
    final output = response?.output; // Check if 'output' contains the response text
    if (output == null || output.isEmpty) {
      throw Exception('No response output from Gemini API');
    }

    // Log the raw output for debugging
    print('Gemini API Output: $output');

    // Try to parse JSON from the output
    final match = RegExp(r'\{.*\}').firstMatch(output);
    if (match == null) {
      throw Exception('No valid JSON found in output: $output');
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