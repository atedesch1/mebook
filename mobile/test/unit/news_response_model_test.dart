import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:mebook/models/news_response_model.dart';

void main() {
  test('News Response Model should support json creation', () {
    NewsResponse newsResponse = NewsResponse.fromJson(jsonDecode('{'
        '"status": "mock-status",'
        '"totalResults": 100,'
        '"articles": ["mock-article-1", "mock-article-2"]'
      '}'));

    expect(newsResponse.status, "mock-status");
    expect(newsResponse.totalResults, 100);
    expect(newsResponse.articles[0], "mock-article-1");
    expect(newsResponse.articles[1], "mock-article-2");
  });
}