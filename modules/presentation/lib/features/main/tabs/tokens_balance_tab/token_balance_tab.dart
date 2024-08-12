import 'package:domain/entities/balance_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/core/base_ui/widgets/base_widget_barrel.dart';
import 'package:presentation/features/main/tabs/tokens_balance_tab/bloc/tokens_balance_cubit.dart';


class TokenBalanceTab extends StatelessWidget {
  const TokenBalanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokensBalancesCubit, TokensBalanceState>(
      builder: (context, state) {
        if (state is TokensBalancesLoadedState) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("Balances"),
                backgroundColor: Colors.transparent,
              ),
              SliverList.separated(
                itemBuilder: (_, index) =>
                    itemBuilder(state.balancesList[index]),
                separatorBuilder: separatorBuilder,
                itemCount: state.balancesList.length,
              ),
              const SliverSizedBox(height: 16),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
    );
  }

  Widget itemBuilder(BalanceEntity item) {
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.tokenName, style: const TextStyle(fontSize: 16)),
            Text(
              '${item.balance} ${item.tokenSymbol}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget separatorBuilder(_, dynamic index) {
    return const SizedBox(height: 2);
  }
}
