import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/widgets/finances/category_tile.dart';
import 'package:mebook/widgets/misc/semi_circle.dart';

class FinancesWheel extends StatelessWidget {
  final List<Transaction> transactions;
  final double diameter;
  final double strokeWidth;

  FinancesWheel({
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
    Map<String, double> expenseByCategory =
        TransactionCategories.getExpenseByCategory(transactions);
    List<Widget> wheelWidgets = getWheelWidgets(transactions);
    List<Widget> categoryTiles = [];
    expenseByCategory
        .forEach((category, expense) => categoryTiles.add(CategoryTile(
              category: category,
              categoryColor: TransactionCategories.categoryColor[category],
              expense: expense,
            )));

    return Row(
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
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                  Text(
                    NumberFormat.simpleCurrency(locale: 'en_US').format(
                        TransactionCategories.getTotalExpense(transactions)),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SemiCircle(
                  diameter: diameter,
                  startAngle: 0,
                  sweepAngle: 359.999,
                  strokeWidth: strokeWidth,
                  color: Colors.white54),
              ...wheelWidgets,
            ],
          ),
        ),
        if (categoryTiles.isNotEmpty) ...[
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: diameter + strokeWidth,
              child: ListWheelScrollView(
                perspective: 0.0015,
                itemExtent: 75,
                squeeze: .9,
                children: categoryTiles,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
