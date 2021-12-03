import 'package:flutter/material.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/widgets/finances/filter_by_month_slider.dart';
import 'package:mebook/widgets/finances/finances_wheel.dart';
import 'package:mebook/widgets/finances/transaction_tile.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/finances/edit_transaction_card.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';

class FinancesScreen extends StatefulWidget {
  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  String _selectedMonthName;

  @override
  Widget build(BuildContext context) {
    final FinancesService financesService = FinancesService(context);

    void updateMonthFilter({
      @required int changeYear,
      @required int selectedMonth,
      @required String selectedMonthName,
    }) {
      setState(() {
        if (changeYear != 0) _selectedYear += changeYear;
        _selectedMonth = selectedMonth;
        _selectedMonthName = selectedMonthName;
      });
    }

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
            padding: EdgeInsets.only(top: 8),
            sliver: SliverFillRemaining(
              child: StreamBuilder<List<Transaction>>(
                stream: FinancesService(context).getTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var transactions = Transaction.filter(
                        transactions: snapshot.data,
                        month: _selectedMonth,
                        year: _selectedYear);
                    transactions.sort((t1, t2) => t2.date.compareTo(t1.date));

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: FinancesWheel(
                            transactions: transactions,
                            diameter: MediaQuery.of(context).size.width * 0.45,
                            strokeWidth: 25.0,
                          ),
                        ),
                        FilterByMonthSlider(
                          emitSelectedMonth: updateMonthFilter,
                          initialMonth: _selectedMonth,
                          key: ValueKey(_selectedYear),
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Transactions',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ))),
                              Text(
                                _selectedYear.toString(),
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
                                'No transactions in $_selectedMonthName',
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
                                editTransaction:
                                    financesService.createOrUpdateTransaction,
                                deleteTransaction:
                                    financesService.deleteTransaction,
                              ),
                              itemCount: transactions.length,
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
