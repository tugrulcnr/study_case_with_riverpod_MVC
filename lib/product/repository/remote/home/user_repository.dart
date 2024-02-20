import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voco_study_case/product/network/model/error/service_error.dart';

import '../../../../features/home/participants/model/user_model.dart';
import '../../../enum/project_enums.dart';

abstract class IUserRepository {
  Future<Either<ServiceError, UsersResponseModel>> getUsers(String page);
}

class UserRepository implements IUserRepository {
  final Dio _networkManager;

  UserRepository(Dio networkManager) : _networkManager = networkManager;

  @override
  Future<Either<ServiceError, UsersResponseModel>> getUsers(String page) async {
    try {
      final response =
          await _networkManager.get(ProjectNetworkPath.users.withQuery(page));

      if (response.statusCode == HttpStatus.ok) {
        return Right(UsersResponseModel.fromJson(response.data));
      }
      return Left(ServiceError.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServiceError.fromJson(e.response!.data));
    }
  }
}
