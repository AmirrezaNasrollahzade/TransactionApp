// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function? removeIndex;
  final Function? removeId;
  const TransactionList(
      {required this.removeId,
      required this.removeIndex,
      required this.transactions});
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Flexible(
            child: Image.asset('assets/images/waiting.png'),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                        onPressed: () => removeId!(
                            transactions[index].id), //removeIndex!(index),

                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}
