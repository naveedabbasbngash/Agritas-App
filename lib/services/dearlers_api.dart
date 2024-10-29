import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dealer.dart';  // Import your Dealer model
import '../utils/logger.dart';  // Import your logger for logging
import '../utils/local_storage.dart';  // Import for local storage if needed

class DealerApi {
  static const String _baseUrl = 'https://www.agritas.com.pk/api/products/dealers';  // Change to your API endpoint
  static List<Dealer>? _cachedDealers;

  // Fetching dealers with optional forceRefresh parameter
  static Future<List<Dealer>> getDealers({bool forceRefresh = false}) async {
    if (_cachedDealers != null && !forceRefresh) {
      Logger.log('Returning cached dealers', tag: 'DealerApi');
      return _cachedDealers!;
    }

    final url = Uri.parse('$_baseUrl');
    Logger.log('Fetching dealers from $url', tag: 'DealerApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'DealerApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'DealerApi');

      if (response.statusCode == 200) {
        // Parsing the dealer list from response
        final List<dynamic> dealersJson = json.decode(response.body)['dealers'];
        Logger.log('Parsed ${dealersJson.length} dealers', tag: 'DealerApi');

        // Mapping JSON to Dealer model
        _cachedDealers = dealersJson.map((json) => Dealer.fromJson(json)).toList();

        // Save to local storage (optional)
        Logger.log('Saving dealers to local storage.', tag: 'DealerApi');
        await LocalStorage.saveDealers(_cachedDealers!);

        return _cachedDealers!;
      } else {
        Logger.error('Failed to load dealers: ${response.statusCode}', tag: 'DealerApi');
        throw Exception('Failed to load dealers');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'DealerApi');
      throw Exception('Failed to load dealers');
    }
  }

  // Get cached dealers
  static List<Dealer>? getCachedDealers() {
    return _cachedDealers;
  }
}
