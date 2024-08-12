import 'package:data/data_sources/wallet_data_source.dart';
import 'package:data/data_sources/wallet_key_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data_sources/data_source_barrel.dart';

Future<void> initDataModule(GetIt getIt) async {
  getIt.registerLazySingleton(() => FlutterSecureStorage());
  final secureStorageService = SecureStorageServiceImpl(getIt());
  getIt.registerLazySingleton<SecureStorageService>(() => secureStorageService);

  getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesServiceImpl());

  getIt.registerSingleton(WalletKeyStorage(getIt()));

  getIt.registerSingleton(WalletLocalDataSource(getIt(), getIt()));

  final dio = createDio();
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton(() => RemoteDataSource(dio));
}

Dio createDio() {
  const contentType = Headers.jsonContentType;
  final baseOptions = BaseOptions(
    baseUrl: '', //ModuleInitVariables.cashbackApiBaseUrl,
    contentType: contentType,
  );

  final dio = Dio(baseOptions);

  return dio;
}
