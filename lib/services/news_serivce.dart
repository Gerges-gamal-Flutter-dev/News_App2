import 'package:dio/dio.dart';
import 'package:flutter_news_app/models/article_model.dart';

//  https://newsapi.org/v2/everything?q=us&apiKey=d4a93323ab804912bcd4beb75e3d467f
class NewsSerivce {
  Future<List<ArticleModel>> getArticles({required String category}) async {
    try {
      var response = await Dio().get(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=d4a93323ab804912bcd4beb75e3d467f');
      Map<String, dynamic> jesonData = response.data;
      List<dynamic> art = jesonData['articles'];

      List<ArticleModel> articles = [];
      for (var article in art) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel model = ArticleModel(
            title: article['title'] ?? "no title",
            description: article['description'],
            image: article['urlToImage'],
            author: article['author'] ?? "no author",
            date: article['publishedAt'] ?? "no date",
          );
          articles.add(model);
        }
      }
      return articles;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
