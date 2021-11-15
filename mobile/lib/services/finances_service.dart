import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class FinancesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User _currentUser;

  FinancesService(BuildContext context) {
    this._currentUser = context.read<AuthService>().currentUser;
  }

  Future<void> createOrUpdateTransaction({
    String docId,
    @required String title,
    @required DateTime date,
    @required double amount,
  }) {
    final ref = _db
        .collection('transactions')
        .doc(_currentUser.uid)
        .collection('items');

    Map<String, dynamic> data = {
      'title': title,
      'date': date,
      'amount': amount,
    };

    if (docId == null) {
      return ref
          .doc()
          .set(data)
          .whenComplete(() => print('Transaction created'))
          .catchError((e) => print(e));
    }

    return ref
        .doc(docId)
        .update(data)
        .whenComplete(
          () => print('Transaction updated'),
        )
        .catchError(
          (e) => print(e),
        );
  }

  Stream<List<Transaction>> getTransactions() {
    final ref = _db
        .collection('transactions')
        .doc(_currentUser.uid)
        .collection('items');

    return ref.snapshots().map((list) => list.docs.map(
          (doc) {
            return Transaction.fromFirestore(doc);
          },
        ).toList());
  }

  Future<void> deleteTransaction(String docId) async {
    final ref = _db
        .collection('transactions')
        .doc(_currentUser.uid)
        .collection('items')
        .doc(docId);

    return ref
        .delete()
        .whenComplete(
          () => print('Transaction deleted'),
        )
        .catchError(
          (e) => print(e),
        );
  }
}
