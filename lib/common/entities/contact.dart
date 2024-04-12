class ContactItem {
  String? id;
  String? name;
  String? description;
  String? avatar;
  int? online;

  ContactItem({
    this.avatar,
    this.description,
    this.name,
    this.online,
    this.id
  });

  factory ContactItem.fromJson(Map<String, dynamic> json) {
    return ContactItem(
      id: json["id"],
      name: json["name"],
      avatar: json["avatar"],
      description: json["description"],
      online: json["online"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatar": avatar,
      "description": description,
      "online": online
    };
  }
}

class ContactResponseEntity {
  int? code;
  String? message;
  List<ContactItem>? data;

  ContactResponseEntity({
    this.data,
    this.message,
    this.code
  });

  factory ContactResponseEntity.fromJson(Map<String, dynamic> json) {
    return ContactResponseEntity(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null
        ? []
        : List<ContactItem>.from(json["data"].map((x) => ContactItem.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "message": message,
      "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson()))
    };
  }
}