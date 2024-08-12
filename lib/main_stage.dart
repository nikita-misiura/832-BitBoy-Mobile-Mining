import 'bootstrap.dart';
import 'config/environment/env/env_barrel.dart';

Future<void> main() async {
  EnvironmentConfig(
    environment: Environment.stage,
    values: EnvironmentValues(
      key: Env.KEY,
      baseUrl: Env.baseUrlStage,
    ),
  );

  await Bootstrap().run();
}