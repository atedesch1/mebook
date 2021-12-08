import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';

class EditTransactionCard extends StatefulWidget {
  final Function editTransaction;
  final Function deleteTransaction;
  final String id;
  final String previousTitle;
  final String previousCategory;
  final DateTime previousDate;
  final double previousAmount;

  EditTransactionCard({
    this.editTransaction,
    this.deleteTransaction,
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
  bool isLoading = false;

  @override
  void initState() {
    _titleController.text = widget.previousTitle;
    _selectedCategory = widget.previousCategory;
    _selectedDate = widget.previousDate;
    _amountController.text =
        widget.previousAmount != null ? widget.previousAmount.toString() : null;
    super.initState();
  }

  void _submitData() async {
    if (!isLoading) {
      isLoading = true;

      TextInputAction.done;

      if (_titleController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Title missing!')),
        );
        isLoading = false;
        return;
      }

      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Select a category first!')),
        );
        isLoading = false;
        return;
      }

      if (_amountController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Amount spent missing!')),
        );
        isLoading = false;
        return;
      }

      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Select a date first!')),
        );
        isLoading = false;
        return;
      }

      final enteredTitle = toBeginningOfSentenceCase(_titleController.text);
      final enteredAmount = double.parse(_amountController.text);

      try {
        await widget.editTransaction(
          docId: widget.id,
          title: enteredTitle,
          category: _selectedCategory,
          date: _selectedDate,
          amount: enteredAmount,
        );

        await Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e}')),
        );
      }
      isLoading = false;
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("2000-01-01 00:00:00Z"),
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
                    items: TransactionCategories.categories
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
                      prefixText: '\$',
                      prefixStyle: TextStyle(color: Colors.black),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _submitData,
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        if (widget.id != null)
                          IconButton(
                            onPressed: () async {
                              if (!isLoading) {
                                isLoading = true;
                                try {
                                  await widget.deleteTransaction(widget.id);
                                  await Navigator.of(context).pop();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: ${e}')),
                                  );
                                }
                                isLoading = false;
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
