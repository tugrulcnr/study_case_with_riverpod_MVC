import 'package:envied/envied.dart';
import 'package:voco_study_case/product/kern/app_environments.dart';
part 'prod_env.g.dart';

@Envied(path: 'assets/env/.prod.env', obfuscate: true)
class ProdEnv implements AppConfiguration {
  @EnviedField(varName: "BASE_URL")
  final String _baseUrl = _ProdEnv._baseUrl;

  @override
  String get baseUrl => _baseUrl;
}
