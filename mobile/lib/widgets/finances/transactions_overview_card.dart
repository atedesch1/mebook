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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 45,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
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
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions in $selectedMonthName',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) => TransactionTile(
                      transaction: transactions[index],
                      editTransaction:
                          financesService.createOrUpdateTransaction,
                      deleteTransaction: financesService.deleteTransaction,
                    ),
                    itemCount: transactions.length,
                  ),
          ),
        ],
      ),
    );
  }
}
