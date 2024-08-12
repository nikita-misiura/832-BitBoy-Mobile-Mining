import "package:bloc/bloc.dart";
import 'package:domain/entities/entities_barrel.dart';
import 'package:domain/repositories/repository.dart';
import 'package:domain/repositories/wallet_repository.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final Repository repository;
  final WalletRepository walletRepository;

  TransactionsCubit(this.repository, this.walletRepository)
      : super(TransactionsLoadingState());

  Future<void> createWallet() async {
    await walletRepository.createWallet();
  }

  Future<void> getTransactions() async {
    late String address;
    try {
       address = await walletRepository.getWalletAddress() ?? '';
    } catch (e){
      address = '';
    }
    final transactions = await repository.fetchTransactions(address);

    emit(TransactionsLoadedState(transactionList: transactions));
  }
}
