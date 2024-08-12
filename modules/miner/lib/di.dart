import 'package:get_it/get_it.dart';
import 'package:miner/domain/repositories/miner_repository.dart';

import 'data/data_barrel.dart';

Future<void> initMinerModule(GetIt getIt) async {
  final minerLauncherService = MinerLauncherServiceImpl();
  getIt.registerLazySingleton<MinerLauncherService>(() => minerLauncherService);

  final minerRepository = MinerRepositoryImpl(getIt());
  getIt.registerLazySingleton<MinerRepository>(() => minerRepository);
}
