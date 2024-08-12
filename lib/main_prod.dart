import 'bootstrap.dart';
import 'config/environment/env/env_barrel.dart';

Future<void> main() async {
  EnvironmentConfig(
    environment: Environment.prod,
    values: EnvironmentValues(
      key: Env.KEY,
      baseUrl: Env.baseUrlProd,
    ),
  );

  await Bootstrap().run();
}