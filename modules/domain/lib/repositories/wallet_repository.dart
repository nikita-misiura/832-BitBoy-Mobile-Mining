import 'package:data/entities/wallet_info.dart';
import 'package:domain/entities/entities_barrel.dart';

abstract class WalletRepository {
  /// Creates a wallet
  Future<String> createWallet();

  /// Export mnemonic, address and private key
  Future<WalletInfo?> exportWalletInfo();

  /// Getting wallet address
  Future<String?> getWalletAddress();

  /// Create wallet and save by mnemonic
  Future<String?> importWalletByMnemonic(String mnemonic);

  /// Create wallet and save by private key
  Future<String?> importWalletByPrivateKey(String privateKey);

  ///delete wallet
  Future<bool> deleteWalletData();

  Future<bool> haveWallet();
}
