import 'package:flutter/material.dart';
import 'package:mebook/models/news_model.dart';
import 'package:mebook/services/news_service.dart';
import 'package:mebook/widgets/news_tile.dart';

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsService newsService = NewsService();

    return Container(
      height: 450,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Today\'s News',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: FutureBuilder(
                future: newsService.getNews(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
                  if (snapshot.hasData) {
                    List<News> news = snapshot.data;
                    return ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (context, index) {
                          var article = news[index];
                          if (article.content != null &&
                              article.description != null) {
                            return NewsTile(news[index]);
                          }
                          return null;
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
