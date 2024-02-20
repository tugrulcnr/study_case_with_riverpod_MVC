import 'package:dio/dio.dart';
import 'package:voco_study_case/product/service/service_locater.dart';
import '../kern/app_environments.dart';
import '../repository/local/local_storage_token.dart';

class ProjectNetworkManager {
  late final Dio _service;
  ProjectNetworkManager._() {
    _service = Dio(BaseOptions(baseUrl: AppEnvironmentsItems.baseUrl.value));

    _service.interceptors.add(DioInterceptor());
  }

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _service;
}


class DioInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await ServiceLocator.read<LocalStorageToken>().getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }
    options.headers['Content-Type'] = "application/json";

    super.onRequest(options, handler);
  }
}