import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/widgets/finances/category_tile.dart';
import 'package:mebook/widgets/misc/semi_circle.dart';

class FinancesSummaryCard extends StatelessWidget {
  final List<Transaction> transactions;
  final double diameter;
  final double strokeWidth;
  final String title;

  FinancesSummaryCard({
    this.title,
    @required this.transactions,
    @required this.diameter,
    @required this.strokeWidth,
  });

  List<Widget> getWheelWidgets(List<Transaction> transactions) {
    if (transactions.length == 1) {
      return [
        SemiCircle(
          diameter: diameter,
          startAngle: -1,
          sweepAngle: 359.9999,
          strokeWidth: strokeWidth,
          color: TransactionCategories.categoryColor[transactions[0].category],
        )
      ];
    }

    Map<String, double> expenseByCategory =
        TransactionCategories.getExpenseByCategory(transactions);

    double totalExpense = TransactionCategories.getTotalExpense(transactions);

    double startAngle = 0;

    Map<String, Map<String, double>> drawingInfo = {};

    expenseByCategory.forEach((category, expense) {
      var expenseDrawingInfo = {
        'startAngle': startAngle,
        'sweepAngle': expense / totalExpense * 360,
      };

      drawingInfo[category] = expenseDrawingInfo;
      startAngle += expenseDrawingInfo['sweepAngle'];
    });

    List<Widget> widgetList = [];

    drawingInfo.forEach((category, info) {
      if (info['sweepAngle'] > 0)
        widgetList.add(SemiCircle(
          diameter: diameter,
          startAngle: info['startAngle'],
          sweepAngle: info['sweepAngle'],
          strokeWidth: strokeWidth,
          color: TransactionCategories.categoryColor[category],
        ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    bool supportsCategoryCards = MediaQuery.of(context).size.width * 0.55 > 160;
    Map<String, double> expenseByCategory =
        TransactionCategories.getExpenseByCategory(transactions);
    List<Widget> wheelWidgets = getWheelWidgets(transactions);
    List<Widget> categoryTiles = [];
    if (supportsCategoryCards)
      expenseByCategory
          .forEach((category, expense) => categoryTiles.add(CategoryTile(
                category: category,
                categoryColor: TransactionCategories.categoryColor[category],
                expense: expense,
              )));

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text(title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              mainAxisAlignment: supportsCategoryCards
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Container(
                  width: diameter + strokeWidth,
                  height: diameter + strokeWidth,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Spent',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          ),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'en_US').format(
                                TransactionCategories.getTotalExpense(
                                    transactions)),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SemiCircle(
                          diameter: diameter,
                          startAngle: -1,
                          sweepAngle: 359.999,
                          strokeWidth: strokeWidth,
                          color: Colors.black12),
                      ...wheelWidgets,
                    ],
                  ),
                ),
                if (categoryTiles.isNotEmpty &&
                    MediaQuery.of(context).size.width * 0.55 > 160) ...[
                  Expanded(
                    child: Container(
                      height: diameter + strokeWidth,
                      child: ListWheelScrollView(
                        perspective: 0.0015,
                        itemExtent: 70,
                        squeeze: .9,
                        children: categoryTiles,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
