import 'dart:convert';
import 'package:http/http.dart' as http;

class InstaApi {
  static const String _apiKey = 'Your API Key';
  static const String _baseUrl = 'https://social-api4.p.rapidapi.com';
  static const Map<String, String> _headers = {
    'X-RapidAPI-Key': _apiKey,
    'X-RapidAPI-Host': 'social-api4.p.rapidapi.com',
  };

  Future<Map<String, dynamic>> _makeApiRequest({
    required String endpoint,
    required Map<String, String> parameters,
  }) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl$endpoint',
      ).replace(queryParameters: parameters);

      final response = await http.get(uri, headers: _headers);

      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody) as Map<String, dynamic>;

      print('API Response (${response.statusCode}): $jsonResponse');

      if (response.statusCode == 403 &&
          jsonResponse['detail'] == 'Private account') {
        return {'status': 'private'};
      }

      if (response.statusCode == 400 &&
          jsonResponse['detail'] == "Invalid 'username_or_id_or_url'") {
        return {'status': 'Invalid'};
      }

      if (response.statusCode == 404 && jsonResponse['detail'] == 'Not found') {
        return {'status': 'no reels'};
      }

      if (response.statusCode == 200) {
        if (jsonResponse.containsKey('data')) {
          return {'status': 'success', 'data': jsonResponse['data']};
        }
        throw Exception('API response missing data field');
      } else {
        throw Exception(
          'API Error ${response.statusCode}: ${jsonResponse['message'] ?? decodedBody}',
        );
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data parsing error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to make API request: $e');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String username) async {
    return _makeApiRequest(
      endpoint: '/v1/info',
      parameters: {'username_or_id_or_url': username},
    );
  }

  Future<Map<String, dynamic>> getUserPosts(String username) async {
    return _makeApiRequest(
      endpoint: '/v1/posts',
      parameters: {'username_or_id_or_url': username},
    );
  }

  Future<Map<String, dynamic>> getUserReels(String username) async {
    return _makeApiRequest(
      endpoint: '/v1/reels',
      parameters: {'username_or_id_or_url': username},
    );
  }

  Future<Map<String, dynamic>> getUserFollowers(String username) async {
    return _makeApiRequest(
      endpoint: '/v1/followers',
      parameters: {'username_or_id_or_url': username},
    );
  }
}
