import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/widgets/finances/edit_transaction_card.dart';
import 'package:mebook/widgets/misc/event_route.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Function editTransaction;
  final Function deleteTransaction;

  TransactionTile({
    @required this.transaction,
    @required this.editTransaction,
    @required this.deleteTransaction,
  });

  void _pushEditTransactionPopup({BuildContext context}) {
    Navigator.of(context).push(ChangeEventRoute(builder: (context) {
      return EditTransactionCard(
        id: transaction.id,
        previousTitle: transaction.title,
        previousCategory: transaction.category,
        previousAmount: transaction.amount,
        previousDate: transaction.date,
        editTransaction: editTransaction,
        deleteTransaction: deleteTransaction,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => _pushEditTransactionPopup(context: context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: TransactionCategories
                          .categoryColor[transaction.category],
                    ),
                    child: Icon(
                      TransactionCategories.categoryIcon[transaction.category],
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          transaction.title,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY)
                              .format(transaction.date),
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '- ${NumberFormat.simpleCurrency(locale: 'en_US').format(transaction.amount)}',
                    style: TextStyle(
                      fontSize: 16,
                      // color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
