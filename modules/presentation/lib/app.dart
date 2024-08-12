import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:presentation/core/constants.dart';
import 'package:presentation/core/extensions/context_extensions.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presentation/di.dart';

import 'core/router/router.dart';
import 'core/router/router_service.dart';
import 'features/main/tabs/tabs_barrel.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppRouter appRouter;

  @override
  void initState() {
    super.initState();

    appRouter = presentationGetIt<RouterService>().appRouter;
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<TokensBalancesCubit>(
          create: (BuildContext context) => TokensBalancesCubit(
            presentationGetIt(),
            presentationGetIt(),
          ),
        ),
        BlocProvider<TransactionsCubit>(
          create: (BuildContext context) => TransactionsCubit(
            presentationGetIt(),
            presentationGetIt(),
          ),
        ),
      ],
      child: GestureDetector(
        // Apply hiding keyboard when touch outside for whole app
        onTap: context.hideKeyboard,
        child: MaterialApp.router(
          title: PresentationConstants.appName,
          theme: ThemeData(),
          routerDelegate: appRouter.delegate(
            deepLinkBuilder: (_) => DeepLink(_initialRoutes),
          ),
          routeInformationParser: appRouter.defaultRouteParser(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
        ),
      ),
    );
  }

  List<PageRouteInfo<dynamic>> get _initialRoutes {
    final initialRoutes = <PageRouteInfo>[];

    initialRoutes.add(const MainRoute());

    return initialRoutes;
  }
}
