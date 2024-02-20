import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_study_case/product/repository/remote/home/user_repository.dart';
import '../../../../product/enum/project_enums.dart';
import '../model/user_model.dart';

class ParticipantsController extends StateNotifier<ProjectState> {
  ParticipantsController(UserRepository userRepository)
      : _userRepository = userRepository,
        super(ProjectState.initial);
  final UserRepository _userRepository;

  final List<UserModel> _users = [];
  UsersResponseModel _usersResponseModel = const UsersResponseModel(
    page: 0,
    perPage: 0,
    total: 0,
    totalPages: 0,
    data: [],
  );

  List<UserModel> get users => _users;

  UsersResponseModel get usersResponseModel => _usersResponseModel;

  Future<void> getUsers(String page) async {
    state = ProjectState.loading;
    final result = await _userRepository.getUsers(page);

    result.fold((serviceError) {
      state = ProjectState.error;
    }, (userResponseModel) {
      _usersResponseModel = userResponseModel;
      _users.addAll(userResponseModel.data);
      state = ProjectState.success;
    });
  }
}
