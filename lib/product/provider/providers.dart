import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_study_case/features/auth/login/controller/login_controller.dart';
import 'package:voco_study_case/features/home/participants/controller/participants_controller.dart';
import 'package:voco_study_case/product/service/service_locater.dart';
import 'package:voco_study_case/product/enum/project_enums.dart';


final loginControllerProvider = StateNotifierProvider<LoginController, ProjectState>(
  (ref) => LoginController(
    authRepository: ProjectServiceItems.authRepository,
    localStorageToken: ProjectServiceItems.tokenLocalStorage,
  ),
);

final participantsControllerProvider = StateNotifierProvider<ParticipantsController, ProjectState>(
  (ref) => ParticipantsController(
    ProjectServiceItems.userRepository,
  ),
);
