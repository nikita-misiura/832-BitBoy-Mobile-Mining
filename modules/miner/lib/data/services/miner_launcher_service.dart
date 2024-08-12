abstract class MinerLauncherService{
  Future<bool?> launch();

  Future<bool?> shutdown();

  Future<bool?> checkPermissions();
}