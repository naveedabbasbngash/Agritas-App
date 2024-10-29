import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/services.dart';
import '../utils/logger.dart';
import '../utils/local_storage.dart';

class ServicesApi {
  static const String _baseUrl = 'https://www.agritas.com.pk/api/products/fetch_service_types';
  static List<Service>? _cachedServices;

  /// Fetch services from API, with caching and optional force refresh
  static Future<List<Service>> getServices({bool forceRefresh = false}) async {
    // If cached data is available and no force refresh is requested, return cached data
    if (_cachedServices != null && !forceRefresh) {
      Logger.log('Returning cached services', tag: 'ServicesApi');
      return _cachedServices!;
    }

    final url = Uri.parse('$_baseUrl');
    Logger.log('Fetching services from $url', tag: 'ServicesApi');

    try {
      final response = await http.get(url);

      // Log the response status and body for debugging
      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'ServicesApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'ServicesApi');

      // If the request is successful, parse the response
      if (response.statusCode == 200) {
        final List<dynamic> servicesJson = json.decode(response.body)['service_types'];
        Logger.log('Parsed ${servicesJson.length} services', tag: 'ServicesApi');
        _cachedServices = servicesJson.map((json) => Service.fromJson(json)).toList();

        // Save the fetched services to local storage
        Logger.log('Saving services to local storage.', tag: 'ServicesApi');
        await LocalStorage.saveServices(_cachedServices!);

        return _cachedServices!;
      } else {
        Logger.error('Failed to load services: ${response.statusCode}', tag: 'ServicesApi');
        throw Exception('Failed to load services');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'ServicesApi');
      throw Exception('Failed to load services');
    }
  }

  /// Get cached services without making a network request
  static List<Service>? getCachedServices() {
    return _cachedServices;
  }
}
