import 'package:miner/data/services/miner_launcher_service.dart';
import 'package:miner/domain/repositories/miner_repository.dart';

class MinerRepositoryImpl extends MinerRepository{
  final MinerLauncherService minerLauncherService;

  MinerRepositoryImpl(this.minerLauncherService);

  @override
  void launch() {
    minerLauncherService.launch();
  }
}