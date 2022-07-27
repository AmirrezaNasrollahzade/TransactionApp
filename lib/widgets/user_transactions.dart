// ignore_for_file: unused_local_variable, camel_case_types

import 'package:flutter/material.dart';
import 'package:transactions/widgets/AddNewTransaction.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';

class User_Transactions extends StatefulWidget {
  const User_Transactions({Key? key}) : super(key: key);

  @override
  State<User_Transactions> createState() => _User_TransactionsState();
}

class _User_TransactionsState extends State<User_Transactions> {
  //list of the Transaction
  final List<Transaction> transactions = [
    Transaction(id: '1', title: 'Shoes', amount: 7.5, date: DateTime.now()),
    Transaction(id: '2', title: 'IceCream', amount: .5, date: DateTime.now()),
  ];
  //Function for add NewTransaction
  void _addNewTransaction(String txTitle, String txAmount) {
    final Transaction newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: double.parse(txAmount),
        date: DateTime.now());
    setState(() {
      transactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Add newTransaction by User
        AddNewTransaction(
          addNewTransaction: _addNewTransaction,
        ),
        //Show list of the Transactions
        TransactionList(
          transactions: transactions,
        ),
      ],
    );
  }
}
