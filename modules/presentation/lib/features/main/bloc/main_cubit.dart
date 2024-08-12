import "package:bloc/bloc.dart";
import 'package:domain/repositories/wallet_repository.dart';
import 'package:miner/domain/repositories/miner_repository.dart';


part 'main_state.dart';

class MainCubit extends Cubit<MainState>{
  final MinerRepository minerRepository;
  final WalletRepository walletRepository;

  MainCubit(this.minerRepository, this.walletRepository) : super(InitialState());

  Future<void> createWallet() async {
    minerRepository.launch();
  }
}