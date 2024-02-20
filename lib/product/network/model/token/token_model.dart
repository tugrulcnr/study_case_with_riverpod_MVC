class TokenModel {
  final String token;
  TokenModel({
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory TokenModel.fromJson(Map<String, dynamic> map) {
    return TokenModel(
      token: map['token'] as String,
    );
  }
}
