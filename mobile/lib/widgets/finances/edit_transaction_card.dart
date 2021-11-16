import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';

class EditTransactionCard extends StatefulWidget {
  final Function editTransaction;
  final String id;
  final String previousTitle;
  final String previousCategory;
  final DateTime previousDate;
  final double previousAmount;

  EditTransactionCard({
    this.editTransaction,
    this.id,
    this.previousTitle,
    this.previousCategory,
    this.previousDate,
    this.previousAmount,
  });

  @override
  State<EditTransactionCard> createState() => _EditTransactionCardState();
}

class _EditTransactionCardState extends State<EditTransactionCard> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory;
  DateTime _selectedDate;

  @override
  void initState() {
    _titleController.text = widget.previousTitle;
    _selectedCategory = widget.previousCategory;
    _selectedDate = widget.previousDate;
    _amountController.text =
        widget.previousAmount != null ? widget.previousAmount.toString() : null;
    super.initState();
  }

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedCategory == null) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    widget.editTransaction(
      docId: widget.id,
      title: enteredTitle,
      category: _selectedCategory,
      date: _selectedDate,
      amount: enteredAmount,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Hero(
          tag: 'Edit Transcation Pop-up',
          createRectTween: (begin, end) {
            return PopUpRectTween(begin: begin, end: end);
          },
          child: Material(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.id == null
                              ? 'New Transaction'
                              : 'Edit Transaction',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(0),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      filled: false,
                      hintText: 'Title',
                    ),
                    style: TextStyle(fontSize: 20),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                  ),
                  DropdownButton(
                    items: TransactionCategories()
                        .categories
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                    elevation: 6,
                    borderRadius: BorderRadius.circular(20),
                    value: _selectedCategory,
                    hint: Text('Category'),
                    onChanged: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      filled: false,
                      hintText: 'Amount',
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _selectedDate == null
                            ? Text(
                                'No Date Chosen!',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                'Date ${DateFormat.yMd().format(_selectedDate)}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.today),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitData,
                          child: Text('Add Transaction'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
