import 'package:flutter/foundation.dart';
import 'dev_env.dart';
import 'prod_env.dart';

abstract class AppConfiguration {
  String get baseUrl;
}

class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration appConfiguration}) {
    _config = appConfiguration;
  }

  AppEnvironment.general() {
    if (kDebugMode) _config = DevEnv();
    _config = ProdEnv();
  }

  static late AppConfiguration _config;
}

enum AppEnvironmentsItems { baseUrl }

extension AppEnvironmentsItemsExtension on AppEnvironmentsItems {
  String get value {
    try {
      switch (this) {
        case AppEnvironmentsItems.baseUrl:
          return AppEnvironment._config.baseUrl;
      }
    } catch (e) {
      throw Exception("EnvironmentsItems: $e");
    }
  }
}
