import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Note {
  final String id;
  final DateTime time;
  final String title;
  final String content;

  Note({
    @required this.id,
    @required this.time,
    @required this.title,
    @required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      time: json['time'] as DateTime,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Note(
      id: doc.id,
      time: data['time'].toDate() ?? DateTime.now(),
      title: data['title'] ?? 'default title',
      content: data['content'] ?? 'default content',
    );
  }
}
