import 'package:flutter/material.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<dynamic> articles;

  NewsResponse({
    @required this.status,
    @required this.totalResults,
    @required this.articles,
  });

  factory NewsResponse.fromJson(dynamic json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'],
    );
  }
}
