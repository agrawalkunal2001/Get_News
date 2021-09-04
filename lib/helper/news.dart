import 'dart:convert';
import 'dart:io';
import 'package:get_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=3e181924374b4955b4018130d947707b";

    var response = await http.get(Uri.parse(url)); // Data from http request

    var jsonData = jsonDecode(response.body); // Decode json data
    print(jsonData);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            articleUrl: element['url'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
          news.add(articleModel);
          print(news);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=3e181924374b4955b4018130d947707b";

    var response = await http.get(Uri.parse(url)); // Data from http request

    var jsonData = jsonDecode(response.body); // Decode json data
    print(jsonData);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: DateTime.parse(element['publishedAt']),
            articleUrl: element["url"],
          );

          news.add(articleModel);
          print(news);
        }
      });
    }
  }
}
