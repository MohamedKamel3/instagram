import 'dart:convert';
import 'package:http/http.dart' as http;

class InstaApi {
  String apiKey = '9242841d31msh180f24748a34103p1516aajsne8f74246495c';
  String baseUrl = 'https://social-api4.p.rapidapi.com';

  Future<String> getUserInfo(String username, Map init) async {
    var url = Uri.parse('$baseUrl/v1/info?username_or_id_or_url=$username');
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'social-api4.p.rapidapi.com',
      },
    );

    var jsonResponse = jsonDecode(response.body) as Map;

    if (response.statusCode == 200) {
      if (jsonResponse.containsKey('data')) {
        init.clear();
        init.addAll(jsonResponse);
      }
      return "200";
    } else {
      return jsonResponse['detail'] ?? "Unknown error";
    }
  }

  Future<String> getUserPosts(String username, Map init) async {
    var url = Uri.parse('$baseUrl/v1/posts?username_or_id_or_url=$username');
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'social-api4.p.rapidapi.com',
      },
    );

    var jsonResponse = jsonDecode(response.body) as Map;

    if (response.statusCode == 200) {
      if (jsonResponse.containsKey('data')) {
        init.clear();
        init.addAll(jsonResponse);
      }
      return "200";
    } else {
      return jsonResponse['detail'] ?? "Unknown error";
    }
  }

  Future<String> getUserReels(String username, Map init) async {
    var url = Uri.parse('$baseUrl/v1/reels?username_or_id_or_url=$username');
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'social-api4.p.rapidapi.com',
      },
    );

    var jsonResponse = jsonDecode(response.body) as Map;

    if (response.statusCode == 200) {
      if (jsonResponse.containsKey('data')) {
        init.clear();
        init.addAll(jsonResponse);
      }
      return "200";
    } else {
      return jsonResponse['detail'] ?? "Unknown error";
    }
  }

  Future<String> getUserFollowers(String username, Map init) async {
    var url = Uri.parse(
      '$baseUrl/v1/followers?username_or_id_or_url=$username',
    );
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'social-api4.p.rapidapi.com',
      },
    );

    var jsonResponse = jsonDecode(response.body) as Map;

    if (response.statusCode == 200) {
      if (jsonResponse.containsKey('data')) {
        init.clear();
        init.addAll(jsonResponse);
      }
      return "200";
    } else {
      return jsonResponse['detail'] ?? "Unknown error";
    }
  }
}
