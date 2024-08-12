import 'package:flutter/services.dart';
import 'package:infrastructure/logger/logger_provider.dart';

import 'miner_launcher_service.dart';

class MinerLauncherServiceImpl extends MinerLauncherService {
  final methodChannel = const MethodChannel('miner_launcher');

  @override
  Future<bool?> launch() async {
    logger.i('launch miner');
    final result = await methodChannel.invokeMethod<bool>('miner.launch');

    return result;
  }

  @override
  Future<bool?> shutdown() async {
    final result = await methodChannel.invokeMethod<bool>(
      'miner.shutdown',
    );

    return result;
  }

  @override
  Future<bool?> checkPermissions() async {

    return methodChannel.invokeMethod<bool>(
      'miner.permissions',
    );
  }
}
