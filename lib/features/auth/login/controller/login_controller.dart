import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../product/network/model/token/token_model.dart';
import '../../../../product/repository/local/local_storage_token.dart';
import '../../../../product/repository/remote/auth/auth_repository.dart';
import '../../../../product/enum/project_enums.dart';
import '../../../../product/widget/snack_bar/project_snackbar.dart';
import '../../../home/participants/view/participants_view.dart';
import '../model/login_request_model.dart';

class LoginController extends StateNotifier<ProjectState>
    with LoginControllerMixin {
  LoginController(
      {required AuthRepository authRepository,
      required LocalStorageToken localStorageToken})
      : _authRepository = authRepository,
        _localStorageToken = localStorageToken,
        super(ProjectState.initial);

  final AuthRepository _authRepository;
  final LocalStorageToken _localStorageToken;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (validateUI(email, password, context)) {
      final LoginRequestModel loginRequestModel =
          LoginRequestModel(email: email, password: password);
      state = ProjectState.loading;
      final result = await _authRepository.login(loginRequestModel);

      result.fold((serviceError) {
        state = ProjectState.error;
        CustomShowSnackBar(
            context: context, message: serviceError.errorMessage);
      }, (token) async {
        await _saveToken(token);
        state = ProjectState.success;
        if (mounted) {
          _navigateToParticipantsView(context);
        }
      });
    }
  }
  Future<void> _saveToken(TokenModel tokenModel) async {
    await _localStorageToken.setToken(tokenModel);
  }
}
_navigateToParticipantsView(BuildContext context) {
  Navigator.pushReplacementNamed(context, ParticipantsView.routeName);
}

mixin LoginControllerMixin on StateNotifier<ProjectState> {
  bool validateUI(String email, String password, BuildContext context) {
    if (email.isEmpty) {
      CustomShowSnackBar(
          context: context, message: "Email is a required field");
      return false;
    } else if (!EmailValidator.validate(email)) {
      CustomShowSnackBar(
          context: context,
          message: "Please enter a valid email",
          type: EnumSnackBarType.error);
      return false;
    } else if (password.isEmpty) {
      CustomShowSnackBar(
          context: context,
          message: "Please enter a valid password",
          type: EnumSnackBarType.error);
      return false;
    } else if (password.length < 6) {
      CustomShowSnackBar(
          context: context,
          message: "Password must be at least 6 digits",
          type: EnumSnackBarType.error);
      return false;
    }
    return true;
  }
}