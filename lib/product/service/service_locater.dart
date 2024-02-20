import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../network/project_network_manager.dart';
import '../repository/local/local_storage_token.dart';
import '../repository/remote/auth/auth_repository.dart';
import '../repository/remote/home/user_repository.dart';

class ServiceLocator {
  ServiceLocator._(); 
  
  static final GetIt _getIt = GetIt.I;

  static void setup() {
    _registerDependencies();
  }

  static void _registerDependencies() {
    _getIt.registerSingleton<Dio>(ProjectNetworkManager.instance.service);
    _getIt.registerLazySingleton(() => AuthRepository(_getIt()));
    _getIt.registerLazySingleton(() => LocalStorageToken());
    _getIt.registerLazySingleton(() => UserRepository(_getIt()));
  }

  static T read<T extends Object>() => _getIt<T>();
}

class ProjectServiceItems {
  ProjectServiceItems._();

  static ProjectNetworkManager get projectServiceManager =>
      ServiceLocator.read<ProjectNetworkManager>();

  static AuthRepository get authRepository =>
      ServiceLocator.read<AuthRepository>();

  static LocalStorageToken get tokenLocalStorage =>
      ServiceLocator.read<LocalStorageToken>();

  static UserRepository get userRepository =>
      ServiceLocator.read<UserRepository>();
}