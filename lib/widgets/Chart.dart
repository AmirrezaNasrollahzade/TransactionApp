// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/widgets/Chart_Bar.dart';

class Chart extends StatelessWidget {
  Chart({Key? key, required this.recentTransactions}) : super(key: key);
  //list of the TransactionsData
  List<Transaction> recentTransactions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedTransactionsValues.map((value) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: value['day'] as String,
                    spendingAmount: value['amount'] as double,
                    spendingPct: totalSpending == 0.0
                        ? 0.0
                        : (value['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }

  //List of the Data Chart Function
  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      //create past days with index
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      //بررسی مطابقت  date transaction  با weekDay جهت ریختن مقادیر در  totalSum
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  //function totalSpending
  double get totalSpending {
    return groupedTransactionsValues.fold(
      0.0,
      (sum, item) {
        return sum + (item['amount'] as double);
      },
    );
  }
}
