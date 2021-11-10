import 'package:flutter/foundation.dart';

class Note {
  final String title;
  final String content;

  Note({
    @required this.title,
    @required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
