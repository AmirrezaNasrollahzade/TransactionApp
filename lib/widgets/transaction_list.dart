// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({required this.transactions});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: transactions.length,
          // children: transactions.map((value) {
          itemBuilder: (ctx, index) {
            return Card(
                elevation: 5,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)
                              // border: Border.all(
                              //   color: Colors.red,
                              //   width: 2,
                              // ),
                              ),
                          child: Text(
                            '\$${transactions[index].amount}', //Value amount
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transactions[index].title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )), //Value title
                              Text(
                                  DateFormat.yMMMd().format(transactions[index]
                                      .date), //Package intl -> DataFormat
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  )), //Value date
                            ])
                      ]),
                ));
          }),
    );
  }
}
