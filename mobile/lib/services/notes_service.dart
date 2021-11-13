import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class NotesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User _currentUser;

  NotesService(BuildContext context) {
    this._currentUser = context.read<AuthService>().currentUser;
  }

  Stream<List<Note>> getNotes() {
    var ref = _db.collection('notes').doc(_currentUser.uid).collection('items');

    return ref.snapshots().map((list) => list.docs.map(
          (doc) {
            return Note.fromFirestore(doc);
          },
        ).toList());
  }

  Future<void> createOrUpdateNote({
    String docId,
    @required String title,
    @required String content,
  }) async {
    var ref = _db.collection('notes').doc(_currentUser.uid).collection('items');

    Map<String, dynamic> data = {
      'time': DateTime.now(),
      'title': title,
      'content': content,
    };

    if (docId == null) {
      return await ref
          .doc()
          .set(data)
          .whenComplete(
            () => print('Note created'),
          )
          .catchError(
            (e) => print(e),
          );
    }

    return await ref
        .doc(docId)
        .update(data)
        .whenComplete(
          () => print('Note updated'),
        )
        .catchError(
          (e) => print(e),
        );
  }

  Future<void> deleteNote(String docId) async {
    var ref = _db
        .collection('notes')
        .doc(_currentUser.uid)
        .collection('items')
        .doc(docId);

    await ref
        .delete()
        .whenComplete(
          () => print('Note deleted'),
        )
        .catchError(
          (e) => print(e),
        );
    ;
  }
}
