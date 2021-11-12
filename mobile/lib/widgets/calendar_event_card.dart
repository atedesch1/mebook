import 'package:flutter/material.dart';
import 'package:mebook/widgets/popup_rect_tween.dart';

const String _CalendarEventPopUp = 'calendar-event-pop-up';

class CalendarEventCard extends StatelessWidget {
  const CalendarEventCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _CalendarEventPopUp,
          createRectTween: (begin, end) {
            return PopUpRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Theme.of(context).backgroundColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO: calendar event card
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
