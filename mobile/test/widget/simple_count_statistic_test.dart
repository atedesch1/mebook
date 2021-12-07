import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mebook/widgets/profile/simple_count_statistic.dart';

void main() {
  testWidgets("Simple count statistic test", (WidgetTester tester) async {
    // init test widget
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new SimpleCountStatistic(count: 10, name: "expenditures")));

    await tester.pumpWidget(testWidget);

    // checks for text
    expect(find.text("10"), findsOneWidget);
    expect(find.text("expenditures"), findsOneWidget);
  });
}
