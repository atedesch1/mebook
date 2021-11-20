import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mebook/widgets/notes/edit_note.dart';

void main() {
  testWidgets("Edit Note Widget Testing", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new EditNote(editNote: () {})));

    await tester.pumpWidget(testWidget);

    // checks for texts and icons on screen
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
    expect(find.text('0/40'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    // expect(find.byIcon(Icons.delete), findsOneWidget);

    // writes a new title with less than 40 characters
    const String title = "My note title";
    await tester.enterText(find.widgetWithText(TextField, 'Title'), title);
    await tester.pump();
    expect(find.text(title), findsOneWidget);
    expect(find.text(title.length.toString() + '/40'), findsOneWidget);

    // writes a new title with more than 40 characters
    String moreThanMaxSizeTitle =
        "test: this title has more than 40 characters";
    String maxSizeTitle = moreThanMaxSizeTitle.substring(0, 40);
    await tester.enterText(
        find.widgetWithText(TextField, title), moreThanMaxSizeTitle);
    await tester.pump();
    expect(find.text(maxSizeTitle), findsOneWidget);
    expect(find.text('40/40'), findsOneWidget);

    // writes a blank title and returns to "Title" suggestion
    await tester.enterText(find.widgetWithText(TextField, maxSizeTitle), "");
    await tester.pump();
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('0/40'), findsOneWidget);

    // writes in content text field
    String content = "Meeting at 13:00 PM";
    await tester.enterText(find.widgetWithText(TextField, "Content"), content);
    await tester.pump();
    expect(find.text(content), findsOneWidget);
  });
}
