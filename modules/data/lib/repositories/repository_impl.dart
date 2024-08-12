import 'package:data/data_sources/remote_data_source.dart';
import 'package:data/data_sources/shared_preferences/shared_preferences_service.dart';
import 'package:data/entities/app_constants.dart';
import 'package:domain/entities/balance_entity.dart';
import 'package:domain/entities/transaction_entity.dart';
import 'package:domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final SharedPreferencesService _sharedPreferences;

  const RepositoryImpl(this.remoteDataSource, this._sharedPreferences);

  @override
  Future<List<BalanceEntity>> fetchBalances() async {
    List<BalanceEntity> mockBalances = [
      const BalanceEntity('Bitcoin', 0.125, 'BTC'),
      const BalanceEntity('Ethereum', 3.456, 'ETH'),
      const BalanceEntity('Litecoin', 15.789, 'LTC'),
      const BalanceEntity('Ripple', 5000, 'XRP'),
      const BalanceEntity('Dogecoin', 100000, 'DOGE'),
      const BalanceEntity('Cardano', 2000, 'ADA'),
      const BalanceEntity('Polkadot', 50, 'DOT'),
      const BalanceEntity('Chainlink', 100, 'LINK'),
      const BalanceEntity('Stellar', 300, 'XLM'),
      const BalanceEntity('Uniswap', 25, 'UNI'),
    ];

    return mockBalances;
  }

  @override
  Future<List<TransactionEntity>> fetchTransactions(String address) async {
    final List<TransactionEntity> transactions = [
      TransactionEntity(
        transactionHash:
            '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
        method: 'Transfer',
        dateTime: '2024-08-05T12:34:56Z',
        from: '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef',
        to: '0x1234567890abcdef1234567890abcdef12345678',
        amount: '0.01',
        tokenSymbol: 'ETH',
        fee: '0.0001',
      ),
      TransactionEntity(
        transactionHash:
            '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef1234567890abcdef12345678',
        method: 'Mint',
        dateTime: '2024-08-05T13:45:00Z',
        from: '0x1234567890abcdef1234567890abcdef12345678',
        to: '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef',
        amount: '100',
        tokenSymbol: 'DAI',
        fee: '0.001',
      ),
      TransactionEntity(
        transactionHash:
            '0x7890abcdef1234567890abcdefabcdefabcdef1234567890abcdefabcdef1234',
        method: 'Swap',
        dateTime: '2024-08-05T14:56:34Z',
        from: '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef',
        to: '0x1234567890abcdef1234567890abcdef12345678',
        amount: '10',
        tokenSymbol: 'USDT',
        fee: null,
      ),
      TransactionEntity(
        transactionHash:
            '0x4567890abcdef1234567890abcdefabcdefabcdef1234567890abcdefabcdef12',
        method: 'Stake',
        dateTime: '2024-08-05T15:00:00Z',
        from: '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef',
        to: '0x1234567890abcdef1234567890abcdef12345678',
        amount: '5',
        tokenSymbol: 'BTC',
        fee: '0.0005',
      ),
      TransactionEntity(
        transactionHash:
            '0xabcdef1234567890abcdefabcdefabcdefabcdef1234567890abcdefabcdef',
        method: 'Unstake',
        dateTime: '2024-08-05T16:30:00Z',
        from: '0x1234567890abcdef1234567890abcdef12345678',
        to: '0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef',
        amount: '2',
        tokenSymbol: 'LINK',
        fee: '0.0002',
      ),
    ];

    return transactions;
  }

  @override
  Future<void> saveFirstLaunch() async {
    final key = AppConstants.isFirstLaunchKey;
    _sharedPreferences.setValue<bool>(key: key, value: true);
  }

  @override
  Future<bool> isFirstLaunch() async {
    final key = AppConstants.isFirstLaunchKey;
    final isFirstLaunch = await _sharedPreferences.getValue<bool>(key: key);

    if (isFirstLaunch != null) return false;

    return true;
  }
}
