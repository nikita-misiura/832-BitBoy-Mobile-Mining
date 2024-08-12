import 'package:domain/entities/entities_barrel.dart';

abstract class Repository{
  Future<List<BalanceEntity>> fetchBalances();

  Future<List<TransactionEntity>> fetchTransactions(String address);

  Future<void> saveFirstLaunch();

  Future<bool> isFirstLaunch();
}