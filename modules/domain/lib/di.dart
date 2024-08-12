import 'package:data/repositories/repositories_barrel.dart';
import 'package:domain/repositories/repositories_barrel.dart';
import 'package:get_it/get_it.dart';


Future<void> initDomainModule(GetIt getIt) async {
  setupRepositories(getIt);
}

void setupRepositories(GetIt getIt) {
  final repository = RepositoryImpl(getIt(), getIt());
  getIt.registerLazySingleton<Repository>(() => repository);

  final walletRepository = WalletRepositoryImpl(getIt());
  getIt.registerLazySingleton<WalletRepository>(() => walletRepository);
}
