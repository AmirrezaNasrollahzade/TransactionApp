// ignore_for_file: must_be_immutable, file_names, deprecated_member_use

import 'package:flutter/material.dart';

class AddNewTransaction extends StatefulWidget {
  final Function? addNewTransaction;

  const AddNewTransaction({required this.addNewTransaction, Key? key})
      : super(key: key);

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  int id = 0;

  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  void submitData() {
    final String title = titleController.text;
    final double amount;
    if (amountController.text == "") {
      amount = 0;
    } else {
      amount = double.parse(amountController.text);
    }

    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.addNewTransaction!(title, amount.toString());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Title TextField
            TextField(
              onSubmitted: (_) => submitData, //submitData Function
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Divider(
              height: 15,
              thickness: 2,
              color: Colors.purple,
            ),
            //Amount TextField
            TextField(
              onSubmitted: (_) => submitData, //submitData Function
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            //Button
            FlatButton(
              textColor: Colors.purple,
              onPressed: submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
