import 'package:dio/dio.dart';
import '../config/env.dart';

class AIService {
  final Dio _dio = Dio();
  
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';

  Future<String> chat(String message, {List<Map<String, String>>? history}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/models/gemini-pro:generateContent?key=${Env.geminiApiKey}',
        data: {
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ]
        },
      );

      if (response.statusCode == 200) {
        final candidates = response.data['candidates'] as List;
        if (candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List;
          if (parts.isNotEmpty) {
            return parts[0]['text'] ?? 'No response';
          }
        }
      }
      
      return 'Failed to get response';
    } catch (e) {
      print('AI Service Error: $e');
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> generateContent({
    required String prompt,
    double temperature = 0.7,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/models/gemini-pro:generateContent?key=${Env.geminiApiKey}',
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': temperature,
            'maxOutputTokens': 1024,
          }
        },
      );

      if (response.statusCode == 200) {
        final candidates = response.data['candidates'] as List;
        if (candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List;
          if (parts.isNotEmpty) {
            return parts[0]['text'] ?? 'No response';
          }
        }
      }
      
      return 'Failed to generate content';
    } catch (e) {
      print('AI Service Error: $e');
      return 'Error: ${e.toString()}';
    }
  }
}
