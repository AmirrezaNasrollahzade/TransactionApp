class Transaction {
  final String title;
  final DateTime date;
  final String id;
  final double amount;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
