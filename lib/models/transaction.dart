import 'package:hive_flutter/hive_flutter.dart';

part "transaction.g.dart";

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final double amount;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
