import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/features/main/tabs/multiply_tab.dart';
import 'package:presentation/features/main/tabs/stake_tab.dart';
import 'package:presentation/features/main/tabs/tabs_barrel.dart';
import 'package:presentation/features/main/widgets/menu_item_widget.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget selectedTab = const TokenBalanceTab();
  MenuItem selectedMenuItem = MenuItem.tokenBalance;

  @override
  void initState() {
    super.initState();

    context.read<TokensBalancesCubit>().getWalletBalances();
    context.read<TransactionsCubit>().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...MenuItem.values.map(
                      (menuItem) => MenuItemWidget(
                        menuItem: menuItem,
                        onMenuTap: onMenuTap,
                        backgroundColor: getBackgroundMenuItemColor(menuItem),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.green.shade500),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: selectedTab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getBackgroundMenuItemColor(MenuItem widgetMenu) {
    return selectedMenuItem == widgetMenu ? Colors.green : Colors.grey;
  }

  void onMenuTap(MenuItem menuItem) {
    selectedMenuItem = menuItem;

    setState(() {
      selectedTab = switch (menuItem) {
        MenuItem.tokenBalance => const TokenBalanceTab(),
        MenuItem.transactions => const TransactionsTab(),
        MenuItem.stake => const StakeTab(),
        MenuItem.multiply => const MultiplyTab()
      };
    });
  }
}

enum MenuItem {
  tokenBalance('Tokens balance'),
  transactions('Transactions'),
  stake('Stake'),
  multiply('Transfer');

  const MenuItem(this.displayName);

  final String displayName;
}
