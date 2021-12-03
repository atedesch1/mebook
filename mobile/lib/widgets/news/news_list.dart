import 'package:flutter/material.dart';
import 'package:mebook/models/news_model.dart';
import 'package:mebook/services/news_service.dart';
import 'package:mebook/widgets/news/news_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    return Expanded(
      child: Scrollbar(
        child: FutureBuilder(
          future: newsService.getNews(),
          builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<News> news = snapshot.data;
              return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return NewsTile(news[index]);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
