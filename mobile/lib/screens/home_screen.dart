import 'package:flutter/material.dart';

import 'package:mebook/widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: NewsCard(),
          ),
        ],
      ),
    );
  }
}
