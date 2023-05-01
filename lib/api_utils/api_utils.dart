import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/news.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiKey = dotenv.env['MICROCMS_API_KEY']!;
String domain = dotenv.env['MICROCMS_SERVICE_DOMAIN']!;

Future<List<Category>> fetchCategories() async {
  final response = await http.get(
    Uri.parse('https://$domain.microcms.io/api/v1/categories'),
    headers: {'X-MICROCMS-API-KEY': apiKey},
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    final contents = parsed['contents'];
    return contents.map<Category>((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<List<News>> fetchNewsArticles(String categoryId) async {
  final response = await http.get(
    Uri.parse(
        'https://$domain.microcms.io/api/v1/news?filters=category[equals]$categoryId'),
    headers: {
      'X-MICROCMS-API-KEY': apiKey,
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    final contents = jsonResponse['contents'];
    return contents.map<News>((json) => News.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news articles');
  }
}
