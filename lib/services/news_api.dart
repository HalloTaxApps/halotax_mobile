import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApi {
  Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a35880b0ec54413aa1a6f8fd709cf3d4'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> data =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return data;
    } else {
      throw Exception('Fetch Failed');
    }
  }
}
