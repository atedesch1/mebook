import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/list_wheel_scroll_view_horizontal.dart';

class FilterByMonthSlider extends StatefulWidget {
  final int initialMonth;
  final Key key;
  final Function emitSelectedMonth;
  final int selectedYear;

  FilterByMonthSlider({
    @required this.emitSelectedMonth,
    @required this.initialMonth,
    @required this.key,
    @required this.selectedYear,
  });

  @override
  State<FilterByMonthSlider> createState() => _FilterByMonthSliderState();
}

class _FilterByMonthSliderState extends State<FilterByMonthSlider> {
  int _selectedMonth;

  @override
  void initState() {
    _selectedMonth = widget.initialMonth;
    super.initState();
  }

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
    'Dec',
  ];

  final Map<String, int> monthsAbbrToIndex = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12,
  };

  bool isEdgeItem(index) => index == 0 || index == months.length + 1;

  int getMonthIndex(index) {
    if (isEdgeItem(index)) return -1;
    return index - 1;
  }

  String getText(monthList, index) {
    int idx = getMonthIndex(index);
    if (idx == -1) {
      return index == 0 ? 'the past' : 'the future...';
    }
    return monthList[idx];
  }

  Widget getBubbleWidget(index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        // width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: isEdgeItem(index) ? null : BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              // offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
          shape: isEdgeItem(index) ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: isEdgeItem(index)
            ? Icon(
                index == 0 ? Icons.arrow_back : Icons.arrow_forward,
                color: Colors.black54,
              )
            : Text(
                getText(monthsAbbr, index),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: index == _selectedMonth
                      ? Theme.of(context).backgroundColor
                      : Colors.black54,
                ),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      child: ListWheelScrollViewHorizontal(
        scrollDirection: Axis.horizontal,
        controller:
            FixedExtentScrollController(initialItem: widget.initialMonth),
        builder: (context, index) => getBubbleWidget(index),
        childCount: months.length + 2,
        itemExtent: 150,
        onSelectedItemChanged: (index) {
          int selectedMonth = index;
          int changeYear = 0;
          if (index == 0) {
            selectedMonth = monthsAbbrToIndex['Dec'];
            changeYear = -1;
          } else if (index == months.length + 1 &&
              widget.selectedYear != DateTime.now().year) {
            selectedMonth = monthsAbbrToIndex['Jan'];
            changeYear = 1;
          }
          widget.emitSelectedMonth(
            changeYear: changeYear,
            selectedMonth: selectedMonth,
            selectedMonthName: getText(months, selectedMonth),
          );
          setState(() {
            _selectedMonth = selectedMonth;
          });
        },
      ),
    );
  }
}
