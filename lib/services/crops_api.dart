import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crops.dart';
import '../utils/logger.dart';
import '../utils/local_storage.dart';

class CropsApi {
  static const String _baseUrl = 'http://agritas.com.pk/api/products/crops';
  static List<Crop>? _cachedCrops;

  static Future<List<Crop>> getCrops({bool forceRefresh = false}) async {
    if (_cachedCrops != null && !forceRefresh) {
      Logger.log('Returning cached crops', tag: 'CropsApi');
      return _cachedCrops!;
    }

    final url = Uri.parse('$_baseUrl');
    Logger.log('Fetching crops from $url', tag: 'CropsApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'CropsApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'CropsApi');

      if (response.statusCode == 200) {
        final List<dynamic> cropsJson = json.decode(response.body)['crops'];
        Logger.log('Parsed ${cropsJson.length} crops', tag: 'CropsApi');
        _cachedCrops = cropsJson.map((json) => Crop.fromJson(json)).toList();

        // Save to local storage
        Logger.log('Saving crops to local storage.', tag: 'CropsApi');
        await LocalStorage.saveCrops(_cachedCrops!);

        return _cachedCrops!;
      } else {
        Logger.error('Failed to load crops: ${response.statusCode}', tag: 'CropsApi');
        throw Exception('Failed to load crops');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'CropsApi');
      throw Exception('Failed to load crops');
    }
  }

  static List<Crop>? getCachedCrops() {
    return _cachedCrops;
  }
}
