import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

class ApiService {
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body) as List;
      return data.map((e) => Article.fromJson(e as Map<String, dynamic>)).toList();
    }

    throw Exception('Failed to load articles');
  }
}
