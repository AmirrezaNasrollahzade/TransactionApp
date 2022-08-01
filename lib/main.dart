import 'package:flutter/material.dart';
import 'package:transactions/widgets/AddNewTransaction.dart';
import 'package:transactions/widgets/Chart.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(const MyApp());

// state MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'KOMIKAB',
        )),
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

//state MyHomePage
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //list of the Transaction
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _startAddNewTransaction(context), //Function _addNewTransaction
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text('Transaction App'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(
                  context), //start AddNewTransaction Function
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Chart
              Chart(recentTransactions: _recentTransactions),
              //Show list of the Transactions
              TransactionList(
                transactions: transactions,
              ),
            ],
          ),
        ),
      ),
    );
  }
  //Functions

  //function _recentTransactions list.where(){} nd .isAfter()
  List<Transaction> get _recentTransactions {
    return transactions.where((test) {
      return test.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  //Function _addNewTransaction
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

  //Function _startAddNewTransaction
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (valueContext) {
          //Add newTransaction by User
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddNewTransaction(addNewTransaction: _addNewTransaction),
          );
        });
  }
}
