import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Mebook', () {
    FlutterDriver driver;

    // connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Verify notes screen operations and connection with firebase',
        () async {
      await driver.waitFor(find.text('Welcome'));
      await driver.waitFor(find.text('Sign In'));
      await driver.waitFor(find.text('Sign Up'));

      // tap sign in button and fill login fields
      await driver.tap(find.text('Sign In'));

      await driver.tap(find.byValueKey('email'));
      await driver.waitFor(find.text(''));
      await driver.enterText('mebook@gmail.com');
      await driver.waitFor(find.text('mebook@gmail.com'));

      await driver.tap(find.byValueKey('password'));
      await driver.waitFor(find.text(''));
      await driver.enterText('mebookapp');
      await driver.waitFor(find.text('mebookapp'));

      // click sign in button
      await driver.tap(find.byValueKey('finishAuthFormButton'));

      // wait for navigation bar and tap Notes icon
      await driver.waitFor(find.text('Home'));
      await driver.waitFor(find.byValueKey('bottomNavigationBar'));
      await driver.tap(find.text('Notes'));

      // wait notes screen to load
      await driver.waitForAbsent(find.byValueKey("noteScreenLoading"));
      await driver.waitFor(find.text('You have no notes!'));

      // add a new note
      await driver.tap(find.byValueKey('addNoteButton'));
      await driver.tap(find.byValueKey('titleEditNote'));
      await driver.waitFor(find.text(''));
      await driver.enterText('Mebook meeting');
      await driver.waitFor(find.text('Mebook meeting'));
      await driver.tap(find.byValueKey('contentEditNote'));
      await driver.enterText('Discuss tests implementation');
      await driver.waitFor(find.text('Discuss tests implementation'));
      await driver.tap(find.byValueKey('addEditNoteIcon'));

      // add a second note
      await driver.tap(find.byValueKey('addNoteButton'));
      await driver.tap(find.byValueKey('titleEditNote'));
      await driver.waitFor(find.text(''));
      await driver.enterText('Most Important Note');
      await driver.waitFor(find.text('Most Important Note'));
      await driver.tap(find.byValueKey('contentEditNote'));
      await driver.enterText('Do not delete');
      await driver.waitFor(find.text('Do not delete'));
      await driver.tap(find.byValueKey('addEditNoteIcon'));

      // long press the two notes and press delete button
      await driver.scroll(
          find.text('Mebook meeting'), 0, 0, Duration(milliseconds: 2000));
      await driver.scroll(
          find.text('Most Important Note'), 0, 0, Duration(milliseconds: 2000));
      await driver.tap(find.byValueKey("deleteNoteButton"));

      // sign out from application
      await driver.waitFor(find.byValueKey('bottomNavigationBar'));
      await driver.tap(find.text('Profile'));
      await driver.tap(find.byValueKey("signOutButton"));

      // sign in again
      await driver.tap(find.text('Sign In'));

      await driver.tap(find.byValueKey('email'));
      await driver.waitFor(find.text(''));
      await driver.enterText('mebook@gmail.com');
      await driver.waitFor(find.text('mebook@gmail.com'));

      await driver.tap(find.byValueKey('password'));
      await driver.waitFor(find.text(''));
      await driver.enterText('mebookapp');
      await driver.waitFor(find.text('mebookapp'));
      await driver.tap(find.byValueKey('finishAuthFormButton'));

      // go to notes screen
      await driver.waitFor(find.text('Home'));
      await driver.waitFor(find.byValueKey('bottomNavigationBar'));
      await driver.tap(find.text('Notes'));

      // add a new note
      await driver.tap(find.byValueKey('addNoteButton'));
      await driver.tap(find.byValueKey('titleEditNote'));
      await driver.waitFor(find.text(''));
      await driver.enterText('This is a note');
      await driver.waitFor(find.text('This is a note'));
      await driver.tap(find.byValueKey('contentEditNote'));
      await driver.enterText('My content');
      await driver.waitFor(find.text('My content'));
      await driver.tap(find.byValueKey('addEditNoteIcon'));

      // edit previous note
      await driver.scroll(
          find.text('This is a note'), 0, 0, Duration(milliseconds: 300));
      await driver.tap(find.byValueKey('titleEditNote'));
      await driver.waitFor(find.text('This is a note'));
      await driver.enterText('Edited note');
      await driver.tap(find.byValueKey('contentEditNote'));
      await driver.waitFor(find.text('My content'));
      await driver.enterText('edited content');
      await driver.waitFor(find.text('edited content'));
      await driver.tap(find.byValueKey('addEditNoteIcon'));

      // delete previous note
      await driver.scroll(
          find.text('Edited note'), 0, 0, Duration(milliseconds: 2000));
      await driver.tap(find.byValueKey("deleteNoteButton"));
    }, timeout: Timeout(Duration(minutes: 1)));
  });
}
