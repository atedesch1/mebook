import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  final double amount;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.date,
    @required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      date: json['date'] as DateTime,
      amount: json['amount'] as double,
    );
  }

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Transaction(
      id: doc.id,
      title: data['title'] ?? 'default title',
      category: data['category'] ?? 'default category',
      date: data['date'].toDate() ?? DateTime.now(),
      amount: data['amount'] ?? 0.0,
    );
  }
}

class TransactionCategories {
  final categories = [
    'Housing',
    'Transportation',
    'Food',
    'Shopping',
    'Saving',
    'Investing'
  ];

  final categoryColor = {
    'Housing': Colors.red,
    'Transportation': Colors.blue,
    'Food': Colors.green,
    'Shopping': Colors.amber,
    'Saving': Colors.lime,
    'Investing': Colors.purple,
  };

  double getTotalExpense(List<Transaction> transactions) {
    return transactions.fold(0, (value, element) => value + element.amount);
  }

  Map<String, List<Transaction>> groupByCategory(
      List<Transaction> transactions) {
    return groupBy(transactions, (Transaction t) => t.category);
  }

  Map<String, double> getExpenseByCategory(List<Transaction> transactions) {
    var map = groupByCategory(transactions);
    return map.map((key, value) => MapEntry(
        key, value.fold(0, (previousValue, element) => element.amount)));
  }
}
