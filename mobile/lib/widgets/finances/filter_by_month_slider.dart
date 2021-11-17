import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/list_wheel_scroll_view_horizontal.dart';

class FilterByMonthSlider extends StatefulWidget {
  final Function emitSelectedMonth;

  FilterByMonthSlider({this.emitSelectedMonth});

  @override
  State<FilterByMonthSlider> createState() => _FilterByMonthSliderState();
}

class _FilterByMonthSliderState extends State<FilterByMonthSlider> {
  int _selectedMonth = DateTime.now().month - 1;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> monthsAbbr = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      child: ListWheelScrollViewHorizontal(
        overAndUnderCenterOpacity: .6,
        scrollDirection: Axis.horizontal,
        controller: FixedExtentScrollController(
          initialItem: DateTime.now().month - 1,
        ),
        builder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            monthsAbbr[index],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: index == _selectedMonth ? Colors.cyan : Colors.black),
          ),
        ),
        childCount: months.length,
        itemExtent: 150,
        onSelectedItemChanged: (index) {
          widget.emitSelectedMonth(
              selectedMonth: index + 1, selectedMonthName: months[index]);
          setState(() {
            _selectedMonth = index;
          });
        },
      ),
    );
  }
}
