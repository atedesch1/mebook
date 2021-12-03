import 'package:flutter/material.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/widgets/finances/transaction_tile.dart';

class TransactionsOverviewCard extends StatelessWidget {
  final int selectedYear;
  final String selectedMonthName;
  final List<Transaction> transactions;
  final FinancesService financesService;

  TransactionsOverviewCard({
    this.transactions,
    this.financesService,
    this.selectedYear,
    this.selectedMonthName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 45,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text('Transactions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))),
              Text(
                selectedYear.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        if (transactions.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'No transactions in $selectedMonthName',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        if (transactions.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) => TransactionTile(
                transaction: transactions[index],
                editTransaction: financesService.createOrUpdateTransaction,
                deleteTransaction: financesService.deleteTransaction,
              ),
              itemCount: transactions.length,
            ),
          ),
      ],
    );
  }
}
