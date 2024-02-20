import 'package:envied/envied.dart';
import 'package:voco_study_case/product/kern/app_environments.dart';
part 'dev_env.g.dart';

@Envied(obfuscate: true, path: 'assets/env/.dev.env')
class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  final String _baseUrl = _DevEnv._baseUrl;

  @override
  String get baseUrl => _baseUrl;
}
