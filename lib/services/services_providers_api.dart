import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/servics_providers.dart';
import '../utils/logger.dart'; // Adjust the import path based on your project structure

class OfficerServiceApi {
  static Future<List<Officer>> fetchOfficers(String city, String typeId) async {
    final url = 'https://www.agritas.com.pk/api/products/fetch_services?city=$city&type_id=$typeId';

    // Log the URL and request initiation
    Logger.log('Fetching officers data', tag: 'OfficerServiceApi');
    Logger.log('URL: $url', tag: 'OfficerServiceApi');

    try {
      final response = await http.get(Uri.parse(url));

      // Log the response status
      Logger.apiResponse('Status Code: ${response.statusCode}', tag: 'OfficerServiceApi');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Log raw response data
        Logger.apiResponse('Response Data: $data', tag: 'OfficerServiceApi');

        if (data['status'] == 200 && data['msg'] == 'success') {
          final List<dynamic> services = data['featured_services'];

          // Log successful data parsing
          Logger.log('Successfully parsed services data', tag: 'OfficerServiceApi');

          return services.map((json) => Officer.fromJson(json)).toList();
        } else {
          Logger.warn('API response unsuccessful: ${data['msg']}', tag: 'OfficerServiceApi');
          throw Exception('Failed to load officers: ${data['msg']}');
        }
      } else {
        Logger.error('Failed to load officers. Status Code: ${response.statusCode}', tag: 'OfficerServiceApi');
        throw Exception('Failed to load officers');
      }
    } catch (e) {
      // Log any exceptions thrown
      Logger.error('Exception occurred: $e', tag: 'OfficerServiceApi');
      rethrow;
    }
  }
}