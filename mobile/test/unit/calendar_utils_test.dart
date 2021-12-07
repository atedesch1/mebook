import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';

void main () {
  test('Should adjust the event time when the end is before the start', () {

    final start_date_0 = DateTime(2021,12,6,15,30); // 06/12/2021 15h30min
    final end_date_0 = DateTime(2021,12,6,18,30);   // 06/12/2021 18h30min
    final timeagg_0 = TimeAggregate(extractDate(start_date_0), extractTimeOfDay(start_date_0), extractDate(end_date_0), extractTimeOfDay(end_date_0));

    adjustBeginToEnd(timeagg_0);

    expect(timeagg_0.m[Scope.StartDate], extractDate(start_date_0));
    expect(timeagg_0.m[Scope.StartTime], extractTimeOfDay(start_date_0));
    expect(timeagg_0.m[Scope.EndDate], extractDate(end_date_0));
    expect(timeagg_0.m[Scope.EndTime], extractTimeOfDay(end_date_0));

    final start_date_1 = DateTime(2021,12,6,15,30); // 06/12/2021 15h30min
    final end_date_1 = DateTime(2021,12,6,18,30);   // 06/12/2021 18h30min
    final timeagg_1 = TimeAggregate(extractDate(start_date_1), extractTimeOfDay(start_date_1), extractDate(end_date_1), extractTimeOfDay(end_date_1));

    adjustEndToBegin(timeagg_1);

    expect(timeagg_1.m[Scope.StartDate], extractDate(start_date_1));
    expect(timeagg_1.m[Scope.StartTime], extractTimeOfDay(start_date_1));
    expect(timeagg_1.m[Scope.EndDate], extractDate(end_date_1));
    expect(timeagg_1.m[Scope.EndTime], extractTimeOfDay(end_date_1));

    // adjustEndtoBegin because of day
    final end_date_2 = DateTime(2021,12,6,18,30);   // 06/12/2021 18h30min
    final start_date_2 = DateTime(2021,12,10,18,30); // 10/12/2021 18h30min
    final new_end_2 = DateTime(2021,12,10,19,30);
    final timeagg_2 = TimeAggregate(extractDate(start_date_2), extractTimeOfDay(start_date_2), extractDate(end_date_2), extractTimeOfDay(end_date_2));

    adjustEndToBegin(timeagg_2);

    expect(timeagg_2.m[Scope.StartDate], extractDate(start_date_2));
    expect(timeagg_2.m[Scope.StartTime], extractTimeOfDay(start_date_2));
    expect(timeagg_2.m[Scope.EndDate], extractDate(new_end_2));
    expect(timeagg_2.m[Scope.EndTime], extractTimeOfDay(new_end_2));

    // adjustEndtoBegin because of hour
    final end_date_3 = DateTime(2021,12,6,18,30);   // 06/12/2021 18h30min
    final start_date_3 = DateTime(2021,12,6,20,30); // 06/12/2021 20h30min
    final new_end_3 = DateTime(2021,12,6,21,30);
    final timeagg_3 = TimeAggregate(extractDate(start_date_3), extractTimeOfDay(start_date_3), extractDate(end_date_3), extractTimeOfDay(end_date_3));

    adjustEndToBegin(timeagg_3);

    expect(timeagg_3.m[Scope.StartDate], extractDate(start_date_3));
    expect(timeagg_3.m[Scope.StartTime], extractTimeOfDay(start_date_3));
    expect(timeagg_3.m[Scope.EndDate], extractDate(new_end_3));
    expect(timeagg_3.m[Scope.EndTime], extractTimeOfDay(new_end_3));

    // adjustBegintoEnd because of day
    final start_date_4 = DateTime(2021,12,6,15,30); // 06/12/2021 15h30min
    final end_date_4 = DateTime(2021,12,5,15,30);   // 05/12/2021 15h30min
    final new_start_4 = DateTime(2021,12,5,14,30);
    final timeagg_4 = TimeAggregate(extractDate(start_date_4), extractTimeOfDay(start_date_4), extractDate(end_date_4), extractTimeOfDay(end_date_4));

    adjustBeginToEnd(timeagg_4);

    expect(timeagg_4.m[Scope.StartDate], extractDate(new_start_4));
    expect(timeagg_4.m[Scope.StartTime], extractTimeOfDay(new_start_4));
    expect(timeagg_4.m[Scope.EndDate], extractDate(end_date_4));
    expect(timeagg_4.m[Scope.EndTime], extractTimeOfDay(end_date_4));

    // adjustBegintoEnd because of hour
    final start_date_5 = DateTime(2021,12,6,15,30); // 06/12/2021 15h30min
    final end_date_5 = DateTime(2021,12,6,11,00);   // 06/12/2021 11h00min
    final new_start_5 = DateTime(2021,12,6,10,00);
    final timeagg_5 = TimeAggregate(extractDate(start_date_5), extractTimeOfDay(start_date_5), extractDate(end_date_5), extractTimeOfDay(end_date_5));

    adjustBeginToEnd(timeagg_5);

    expect(timeagg_5.m[Scope.StartDate], extractDate(new_start_5));
    expect(timeagg_5.m[Scope.StartTime], extractTimeOfDay(new_start_5));
    expect(timeagg_5.m[Scope.EndDate], extractDate(end_date_5));
    expect(timeagg_5.m[Scope.EndTime], extractTimeOfDay(end_date_5));

  });
}