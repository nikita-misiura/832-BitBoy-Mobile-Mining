import 'package:bitboy/config/environment/env/env_barrel.dart';
import 'package:data/di.dart';
import 'package:domain/di.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/di.dart';
import 'package:infrastructure/logger/logger_barrel.dart';
import 'package:presentation/di.dart';
import 'package:miner/di.dart';

final getIt = GetIt.instance;

Future<void> initApplication() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  final envConfig = EnvironmentConfig.instance;
  final env = envConfig.environment;
  final envName = env.name;
  final envValues = envConfig.values;

  final loggerEnv = _getLoggerEnvironment(env);
  await LoggerProvider.createLogger(loggerEnv);
  
  await setupModules();
}

Future<void> setupModules() async {
  await initInfrastructureModule(getIt);
  await initMinerModule(getIt);
  await initDataModule(getIt);
  await initDomainModule(getIt);
  await initPresentationModule(getIt);
}

LogEnvironment _getLoggerEnvironment(Environment env) {
  return env == Environment.dev ? LogEnvironment.dev : LogEnvironment.prod;
}