import 'package:domain/entities/entities_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/features/main/tabs/tabs_barrel.dart';

import '../../../../core/base_ui/widgets/base_widget_barrel.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsLoadedState) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("Transactions"),
                backgroundColor: Colors.transparent,
              ),
              SliverList.separated(
                itemBuilder: (_, index) =>
                    itemBuilder(state.transactionList[index]),
                separatorBuilder: separatorBuilder,
                itemCount: state.transactionList.length,
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

  Widget itemBuilder(TransactionEntity item) {
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.transactionHash,
              style: const TextStyle(
                  fontSize: 16, overflow: TextOverflow.ellipsis,),
            ),
            Text(
              item.from,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              item.to,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              item.method,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              item.dateTime,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${item.amount} ${item.tokenSymbol}',
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
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
