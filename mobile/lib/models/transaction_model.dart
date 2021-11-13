import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final DateTime date;
  final double amount;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as DateTime,
      amount: json['amount'] as double,
    );
  }

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Transaction(
      id: doc.id,
      title: data['title'] ?? 'default title',
      date: data['date'].toDate() ?? DateTime.now(),
      amount: data['amount'] ?? 0.0,
    );
  }
}
