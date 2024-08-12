class TransactionEntity {
  final String transactionHash;
  final String method;
  final String dateTime;
  final String from;
  final String to;
  final String amount;
  final String tokenSymbol;
  final String? fee;

  const TransactionEntity({
    required this.transactionHash,
    required this.method,
    required this.dateTime,
    required this.from,
    required this.to,
    required this.amount,
    required this.tokenSymbol,
    this.fee,
  });
}
