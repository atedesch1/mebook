import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/finances/edit_transaction_card.dart';

class FinancesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Finances',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(ChangeEventRoute(builder: (context) {
                      return EditTransactionCard();
                    }));
                  },
                  icon: Icon(Icons.add_circle_outline))
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
