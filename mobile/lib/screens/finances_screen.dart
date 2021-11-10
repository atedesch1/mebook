import 'package:flutter/material.dart';

class FinancesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(
            child: Text('Finances'),
          ),
        ],
      ),
    );
  }
}
