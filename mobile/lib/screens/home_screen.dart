import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';

import 'package:mebook/widgets/news/news_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          OverlayAppBar(
            title: 'Home',
            actions: [],
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  NewsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
