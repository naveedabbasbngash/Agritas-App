import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/problems.dart';
import '../utils/logger.dart';  // Logger utility
import '../utils/local_storage.dart';  // LocalStorage utility for Hive

class ProblemsApi {
  static const String _baseUrl = 'https://www.agritas.com.pk/api/products/all_problems';
  static List<ProblemCategory>? _cachedProblemCategories;

  /// Fetches the problems from the API or returns cached data
  static Future<List<ProblemCategory>> getProblemCategories({bool forceRefresh = false}) async {
    // If we have cached data and no force refresh, return the cached version
    if (_cachedProblemCategories != null && !forceRefresh) {
      Logger.log('Returning cached problem categories', tag: 'ProblemsApi');
      return _cachedProblemCategories!;
    }

    final url = Uri.parse(_baseUrl);
    Logger.log('Fetching problem categories from $url', tag: 'ProblemsApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'ProblemsApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'ProblemsApi');

      if (response.statusCode == 200) {
        final List<dynamic> problemsJson = json.decode(response.body)['all_problems'];
        Logger.log('Parsed ${problemsJson.length} problem categories', tag: 'ProblemsApi');

        // Parse JSON into ProblemCategory objects
        _cachedProblemCategories = problemsJson.map((json) => ProblemCategory.fromJson(json)).toList();

        // Save to local storage using Hive
        Logger.log('Saving problem categories to local storage.', tag: 'ProblemsApi');
        await LocalStorage.saveProblemCategories(_cachedProblemCategories!);

        return _cachedProblemCategories!;
      } else {
        Logger.error('Failed to load problem categories: ${response.statusCode}', tag: 'ProblemsApi');
        throw Exception('Failed to load problem categories');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'ProblemsApi');
      throw Exception('Failed to load problem categories');
    }
  }

  /// Returns the cached problem categories (if available)
  static List<ProblemCategory>? getCachedProblemCategories() {
    return _cachedProblemCategories;
  }
}
