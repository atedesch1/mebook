import 'package:flutter/material.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/widgets/finances/finances_summary.dart';
import 'package:mebook/widgets/misc/home_card.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/news/news_list.dart';
import 'package:mebook/widgets/schedule/todays_events_summary.dart';

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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                HomeCard(
                  title: 'Today\'s Events',
                  widgets: [
                    TodaysEventsSummary(),
                  ],
                ),
                HomeCard(
                  title: 'This Month\'s Spendings',
                  widgets: [
                    StreamBuilder<List<Transaction>>(
                      stream: FinancesService(context).getTransactions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var transactions = Transaction.filter(
                              transactions: snapshot.data,
                              month: DateTime.now().month);
                          transactions
                              .sort((t1, t2) => t2.date.compareTo(t1.date));
                          return FinancesSummary(transactions: transactions);
                        } else {
                          return Container(
                            height: 100,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  ],
                ),
                HomeCard(
                  height: 450,
                  title: 'Today\'s News',
                  widgets: [
                    NewsList(),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
