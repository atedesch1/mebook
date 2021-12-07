@Timeout(Duration(minutes: 2))

import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('calendar', () {
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

    test('Authenticate with firebase', () async {
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
      await driver.tap(find.text('Schedule'));

      // wait notes screen to load
      await driver.waitForAbsent(find.byValueKey('scheduleScreenLoading'));
      await driver.waitFor(find.text('No events for the selected day'));

      // add a new event
      await driver.tap(find.byValueKey('addEventButton'));
      await driver.tap(find.byValueKey('editEventTitle'));
      await driver.waitFor(find.text(''));
      await driver.enterText('Walk with dog');

      await driver.waitFor(find.text('Walk with dog'));
      await driver.tap(find.byValueKey('editEventStartDayButton'));
      await driver.waitFor(find.text('SELECT DATE'));
      await driver.tap(find.text('7'));
      await driver.tap(find.text('OK'));

      await driver.tap(find.byValueKey('editEventStartTimeButton'));
      await driver.waitFor(find.text('SELECT TIME'));
      double angle = 4*(360/24)*pi/180; // 10 hours direction
      await driver.scroll(
          find.byValueKey('time-picker-dial'),
          15*cos(angle),
          15*sin(angle),
          Duration(seconds: 2)
      );
      await driver.tap(find.text('OK'));

      await driver.waitFor(find.text('Walk with dog'));
      await driver.tap(find.byValueKey('editEventEndTimeButton'));
      await driver.waitFor(find.text('SELECT TIME'));
      await driver.scroll(
          find.byValueKey('time-picker-dial'),
          15*cos(angle),
          15*sin(angle),
          Duration(seconds: 1)
      );
      angle = 6*(360/24)*pi/180; // 30 minutes direction
      await driver.scroll(
        find.byValueKey('time-picker-dial'),
        15*cos(angle),
        15*sin(angle),
        Duration(seconds: 1),
      );
      await driver.tap(find.text('OK'));

      await driver.waitFor(find.text('Walk with dog'));
      await driver.tap(find.byValueKey('finishEventEditButton'));

      await driver.waitFor(find.byValueKey('deleteEventButton'));
      await driver.tap(find.byValueKey('deleteEventButton'));

      // sign out from application
      await driver.waitFor(find.byValueKey('bottomNavigationBar'));
      await driver.tap(find.text('Profile'));
      await driver.tap(find.byValueKey("signOutButton"));
    });
  });
}