// login result
class UserItem {
  String? accessToken;
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;

  UserItem({
    this.accessToken,
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type
  });

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      UserItem(
        accessToken: json["accessToken"],
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        online: json["online"],
        type: json["type"]
      );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "token": token,
    "name": name,
    "description": description,
    "avatar": avatar,
    "online": online,
    "type": type
  };
}