import 'package:equatable/equatable.dart';
import 'package:voco_study_case/features/home/participants/model/user_model.dart';

class UsersResponseModel extends Equatable {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> data;

  const UsersResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      UsersResponseModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        totalPages,
        data,
      ];
}
