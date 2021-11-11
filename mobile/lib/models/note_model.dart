import 'package:flutter/foundation.dart';

class Note {
  final int id;
  final String title;
  final String content;

  Note({
    @required this.id,
    @required this.title,
    @required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
