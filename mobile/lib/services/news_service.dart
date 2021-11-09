import 'dart:convert';
import 'package:http/http.dart';
import 'package:mebook/models/news_model.dart';
import 'package:mebook/models/news_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsService {
  final Uri newsURL = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=${dotenv.env['NEWS_API_KEY']}");

  Future<List<News>> getNews() async {
    Response res = await get(newsURL);

    if (res.statusCode == 200) {
      NewsResponse newsRes = NewsResponse.fromJson(jsonDecode(res.body));

      List<News> news = newsRes.articles
          .map(
            (dynamic item) => News.fromJson(item),
          )
          .toList();

      return news;
    } else {
      throw "Unable to retrieve news.";
    }
  }
}
