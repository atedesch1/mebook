import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';

class SelectCalendarCard extends StatelessWidget {
  final MapEntry<String, Map<String, dynamic>> previouslySelected;
  final Map<String, Map<String, dynamic>> calendars;
  final Function selectCalendarFunction;

  SelectCalendarCard({
    @required this.previouslySelected,
    @required this.calendars,
    @required this.selectCalendarFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Hero(
          tag: 'Select Calendar Pop-up',
          createRectTween: (begin, end) {
            return PopUpRectTween(begin: begin, end: end);
          },
          child: Material(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  calendars.values.toList()[index]['name'],
                  style: TextStyle(
                    color:
                        calendars.keys.toList()[index] == previouslySelected.key
                            ? Colors.purple
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  selectCalendarFunction(calendars.entries.toList()[index]);
                  Navigator.of(context).pop();
                },
              ),
              itemCount: calendars.keys.length,
            ),
          ),
        ),
      ),
    );
  }
}
