import 'package:get_it/get_it.dart';

import 'core/router/router_service.dart';

late final GetIt presentationGetIt;

Future<void> initPresentationModule(GetIt getIt) async {
  presentationGetIt = getIt;

  setUpRouter();
}

void setUpRouter() {
  presentationGetIt.registerFactory<RouterService>(() => RouterService());
}