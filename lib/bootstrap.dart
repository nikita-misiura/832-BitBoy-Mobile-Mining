import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/app.dart';

import 'init_application.dart';


final class Bootstrap {
  Future<void> run() async {
    await initApplication();

    runApp(
      ScreenUtilInit(
        minTextAdapt: true,
        child: const App(),
        builder: (_, __) => const App(),
      ),
    );
  }
}
