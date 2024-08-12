import 'package:equatable/equatable.dart';

class WalletInfo extends Equatable {
  /// Wallet's public address in Ethereum network.
  final String privateKey;

  /// Wallet's mnemonic
  final String mnemonic;

  /// Wallet's address
  final String address;

  const WalletInfo({
    required this.privateKey,
    required this.mnemonic,
    required this.address,
  });

  @override
  List<Object?> get props => [privateKey, mnemonic, address];
}
