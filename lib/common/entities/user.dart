class UserItem {
  String? accessToken;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;

  UserItem({
    this.accessToken,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      UserItem(
        accessToken: json["access_token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        online: json["online"],
        type: json["type"]
      );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "name": name,
    "description": description,
    "avatar": avatar,
    "online": online,
    "type": type
  };
}

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? openId;
  int? online;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.openId,
    this.online
  });

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "description": description,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "openId": openId,
    "online": online
  };
}

class TokenEntity {
  String? accessToken;
  String? refreshToken;

  TokenEntity({
    this.accessToken,
    this.refreshToken
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"]
    );
  }
}

class LoginResponseEntity {
  int? code;
  String? message;
  TokenEntity? data;

  LoginResponseEntity({
    this.code,
    this.message,
    this.data
  });

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return LoginResponseEntity(
        code: json["code"],
        message: json["message"],
        data: TokenEntity.fromJson(json["data"]),
      );
  }
}