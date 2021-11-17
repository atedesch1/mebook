import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final Color categoryColor;
  final double expense;

  CategoryTile({this.category, this.categoryColor, this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(minWidth: 150, maxWidth: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: categoryColor,
                ),
              ),
              Expanded(
                child: Text(
                  category,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.paid,
                  size: 10,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(locale: 'en_US').format(expense),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
