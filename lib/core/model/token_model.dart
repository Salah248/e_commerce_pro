class TokenModel {
  final String? token;

  TokenModel(this.token);

  TokenModel.fromJson(Map<String, dynamic> json) : token = json['token'];

  Map<String, dynamic> toJson() => {'token': token};
}
