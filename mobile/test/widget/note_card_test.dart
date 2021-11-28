import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/widgets/notes/note_card.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets("Edit Note Widget Test", (WidgetTester tester) async {
    // note example
    Note note = Note(
        id: "0",
        time: DateTime(2021, 20, 11),
        title: "note title",
        content: "note content");

    // init test widget
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new NoteCard(note, Colors.white, null, null, null)));

    await tester.pumpWidget(testWidget);

    // checks for text on note card
    String dateScreen =
        DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(note.time).toString();
    expect(find.text("note title"), findsOneWidget);
    expect(find.text("note content"), findsOneWidget);
    expect(find.text(dateScreen), findsOneWidget);
  });
}
