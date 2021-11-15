import 'package:flutter/material.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/finances/edit_transaction_card.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';

class FinancesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FinancesService financesService = FinancesService(context);

    void _pushEditTransactionPopup(
        {BuildContext context, Function editTransaction}) {
      Navigator.of(context).push(ChangeEventRoute(builder: (context) {
        return EditTransactionCard(
            editTransaction: financesService.createOrUpdateTransaction);
      }));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          OverlayAppBar(
            title: 'Finances',
            actions: [
              IconButton(
                  onPressed: () => _pushEditTransactionPopup(
                        context: context,
                        editTransaction:
                            financesService.createOrUpdateTransaction,
                      ),
                  icon: Icon(Icons.add_circle_outline)),
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
