import 'package:flutter/material.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/widgets/finances/filter_by_month_slider.dart';
import 'package:mebook/widgets/finances/finances_summary.dart';
import 'package:mebook/widgets/finances/transactions_overview_card.dart';
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
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
                          child: FinancesSummary(transactions: transactions),
                        ),
                        FilterByMonthSlider(
                          emitSelectedMonth: updateMonthFilter,
                          initialMonth: _selectedMonth,
                          selectedYear: _selectedYear,
                          key: ValueKey(_selectedYear),
                        ),
                        Expanded(
                          child: TransactionsOverviewCard(
                            transactions: transactions,
                            financesService: financesService,
                            selectedYear: _selectedYear,
                            selectedMonthName: _selectedMonthName,
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
