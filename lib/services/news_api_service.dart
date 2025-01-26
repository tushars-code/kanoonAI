import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String _apiKey = '2597bead-9d4b-490b-b4fa-af1b89b56e7c'; // Replace with your API key
  static const String _baseUrl =
      'https://eventregistry.org/api/v1/article/getArticles';

  /// Fetch articles with custom query parameters
  static Future<List<dynamic>> fetchNews({
    String? keyword,
    String lang = 'eng',
    int articlesCount = 10,
    String? dateStart,
    String? dateEnd,
    int articlesPage = 1,
    bool includeBody = true,
  }) async {
    // Build the request body dynamically
    final Map<String, dynamic> requestBody = {
      'action': 'getArticles',
      'apiKey': _apiKey,
      'articlesCount': articlesCount,
      'articlesPage': articlesPage,
      'lang': lang,
      'includeArticleBody': includeBody,
    };

    // Optional parameters
    if (keyword != null && keyword.isNotEmpty) {
      requestBody['keyword'] = keyword;
    }
    if (dateStart != null && dateStart.isNotEmpty) {
      requestBody['dateStart'] = dateStart;
    }
    if (dateEnd != null && dateEnd.isNotEmpty) {
      requestBody['dateEnd'] = dateEnd;
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the response structure is as expected
        if (data['articles'] != null && data['articles']['results'] != null) {
          return List<dynamic>.from(data['articles']['results']);
        } else {
          throw Exception('Unexpected response format.');
        }
      } else {
        throw Exception(
          'Failed to load news. Status Code: ${response.statusCode}\nResponse: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
