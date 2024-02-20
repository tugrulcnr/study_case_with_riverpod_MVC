import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import '../kern/app_environments.dart';
import '../service/service_locater.dart';

@immutable
class ApplicationInitialize {
  Future<void> start() async {
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      Logger().e(error.toString());
    });
  }

  Future<void> _initialize() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await DeviceUtility.instance.initPackageInfo();
    FlutterError.onError = (details) {
      Logger().e(details.exceptionAsString(), error: details.exception);
    };
    AppEnvironment.general();
    ServiceLocator.setup();
  }
}
