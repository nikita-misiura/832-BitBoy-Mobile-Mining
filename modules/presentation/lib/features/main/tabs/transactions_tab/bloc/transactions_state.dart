part of 'transactions_cubit.dart';

abstract class TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final List<TransactionEntity> transactionList;

  TransactionsLoadedState({required this.transactionList});
}
