import 'package:flutter/material.dart';

import 'package:mebook/widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NewsCard(),
        ],
      ),
    );
  }
}
