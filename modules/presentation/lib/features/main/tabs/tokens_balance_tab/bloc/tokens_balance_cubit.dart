import "package:bloc/bloc.dart";
import 'package:domain/entities/balance_entity.dart';
import 'package:domain/repositories/repository.dart';
import 'package:domain/repositories/wallet_repository.dart';

part 'tokens_balance_state.dart';

class TokensBalancesCubit extends Cubit<TokensBalanceState> {
  final Repository repository;
  final WalletRepository walletRepository;

  TokensBalancesCubit(this.repository, this.walletRepository)
      : super(TokensBalancesLoadingState());

  Future<void> createWallet() async {
    await walletRepository.createWallet();
  }

  Future<void> getWalletBalances() async {
    final balances = await repository.fetchBalances();

    emit(TokensBalancesLoadedState(balancesList: balances));
  }
}
