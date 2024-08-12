import 'package:bitboy/bootstrap.dart';

import 'config/environment/env/env_barrel.dart';


Future<void> main() async {
  EnvironmentConfig(
    environment: Environment.dev,
    values: EnvironmentValues(
      key: Env.KEY,
      baseUrl: Env.baseUrlDev,
    ),
  );

  await Bootstrap().run();
}