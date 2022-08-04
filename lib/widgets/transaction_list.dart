// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Box<Transaction> boxTransaction;
  final Function? removeIndex;
  final Function? removeId;
  const TransactionList(
      {required this.removeId,
      required this.removeIndex,
      required this.boxTransaction});
  @override
  Widget build(BuildContext context) {
    return boxTransaction.isEmpty
        ? const Expanded(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(4),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      // semanticsLabel: 'Nothing!',
                      // semanticsValue: 'Nothing Here !',
                    ),
                  )),
            ),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: boxTransaction.length,
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
                            child: Text(
                                '\$${boxTransaction.getAt(index)!.amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        boxTransaction.getAt(index)!.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(boxTransaction.getAt(index)!.date)),
                      trailing: IconButton(
                        onPressed: () => removeId!(boxTransaction
                            .getAt(index)!
                            .id), //removeIndex!(index)
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
/*
() => removeId!(
                            transactions[index].id), //removeIndex!(index),
*/