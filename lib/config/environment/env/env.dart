import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
final class Env {
  const Env._();

  // Sentry
  @EnviedField(varName: 'KEY')
  static final String KEY = _Env.KEY;
  // Sentry
  @EnviedField(varName: 'BASE_URL_DEV')
  static final String baseUrlDev = _Env.baseUrlDev;
  // Sentry
  @EnviedField(varName: 'BASE_URL_STAGE')
  static final String baseUrlStage = _Env.baseUrlStage;
  // Sentry
  @EnviedField(varName: 'BASE_URL_PROD')
  static final String baseUrlProd = _Env.baseUrlProd;
}
