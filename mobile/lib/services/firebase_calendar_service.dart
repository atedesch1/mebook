import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'package:mebook/services/auth_service.dart';
import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/models/event_model.dart';

class FirebaseCalendarService extends AbstractCalendarService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String _eventsCollectionName = 'events';
  String _userEventsCollectionName = 'items';
  User _currentUser;

  FirebaseCalendarService(BuildContext context) {
    this._currentUser = context.read<AuthService>().currentUser;
  }

  Future<List<Event> > getMonthEvents(DateTime chosenMonth) async {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));
    var querySnap = await _db
        .collection(_eventsCollectionName)
        .doc(_currentUser.uid)
        .collection(_userEventsCollectionName)
        .where('startTime', isGreaterThan: firstDayOfMonth.toString())
        .where('startTime', isLessThan: lastDayOfMonth.toString())
        .get();

    return querySnap.docs.map((doc) => Event.fromFirestore(doc)).toList();
  }

  Future<List<Event> > getDailyEvents(DateTime chosenDay) async {
    var firstTimeOfDay = DateTime(
        chosenDay.year,
        chosenDay.month,
        chosenDay.day
    );
    var lastTimeOfDay = firstTimeOfDay.add(Duration(days: 1));
    var querySnap = await _db
        .collection(_eventsCollectionName)
        .doc(_currentUser.uid)
        .collection(_userEventsCollectionName)
        .where('startTime', isGreaterThan: firstTimeOfDay.toString())
        .where('startTime', isLessThan: lastTimeOfDay.toString())
        .get();

    return querySnap.docs.map((doc) => Event.fromFirestore(doc)).toList();
  }

  Future<void> updateEvent({
    @required Event event,
    String title,
    DateTime start,
    DateTime end,
  }) {
    var ref = _db
        .collection(_eventsCollectionName)
        .doc(_currentUser.uid)
        .collection(_userEventsCollectionName);
    Event e = Event(
      id: event.id,
      title: title,
      startTime: start,
      endTime: end,
    );

    return ref.doc(e.id).update(e.toFirestore()).whenComplete(
      () => print('Event updated'),
    ).catchError(
      (e) => print(e),
    );
  }

  Future<void> createEvent({
    @required String title,
    @required DateTime start,
    @required DateTime end,
  }) {
    var ref = _db
        .collection(_eventsCollectionName)
        .doc(_currentUser.uid)
        .collection(_userEventsCollectionName);
    Event e = Event(
      id: '',
      title: title,
      startTime: start,
      endTime: end,
    );

    return ref.doc().set(e.toFirestore()).whenComplete(
        () => print('Event created'),
    ).catchError(
        (e) => print(e),
    );
  }

  Future<void> deleteEvent(String id) {
    var ref = _db
        .collection(_eventsCollectionName)
        .doc(_currentUser.uid)
        .collection(_userEventsCollectionName).doc(id);

    return ref.delete().whenComplete(
      () => print('Event deleted'),
    ).catchError(
        (e) => print(e),
    );
  }
}