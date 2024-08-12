part of 'tokens_balance_cubit.dart';

abstract class TokensBalanceState {}

class TokensBalancesLoadingState extends TokensBalanceState {}

class TokensBalancesLoadedState extends TokensBalanceState {
  final List<BalanceEntity> balancesList;

  TokensBalancesLoadedState({required this.balancesList});
}
