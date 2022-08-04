import 'package:flutter/material.dart';
import 'package:transactions/widgets/AddNewTransaction.dart';
import 'package:transactions/widgets/Chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

const String transactionBox = "transaction";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>(transactionBox);
  runApp(const MyApp());
}

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
  final List<Transaction> transactionsList = [];
  final myBox = Hive.box<Transaction>(transactionBox);

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
              //SizedBox
              const SizedBox(height: 20),
              //Show list of the Transactions
              TransactionList(
                boxTransaction: myBox,
                removeIndex: removeIndex,
                removeId: removeId,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Functions

  //function remove transaction with .removeWhere
  void removeId(String id) async {
    //transactionsList.removeWhere((element) => element.id == id);
    for (int i = 0; i < myBox.length; i++) {
      Transaction? transactionIndex = myBox.getAt(i);
      if (transactionIndex!.id == id) {
        await myBox.deleteAt(i);
      }
    }
    setState(() {});
  }

  //function remove transaction with index Transaction
  void removeIndex(int index) {
    setState(() {
      transactionsList.removeAt(index);
    });
  }

  //function _recentTransactions list.where(){} nd .isAfter()
  List<Transaction> get _recentTransactions {
    return transactionsList.where((test) {
      return test.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  //Function _addNewTransaction
  void _addNewTransaction(
    String txTitle,
    String txAmount,
    DateTime chosenDate,
  ) async {
    final Transaction newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: double.parse(txAmount),
        date: chosenDate);
    await myBox.add(newTx);
    setState(() {});
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
