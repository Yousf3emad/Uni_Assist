/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.studentEmail,
        required this.message,
        required this.status,
        required this.token,
    });

    StudentEmail studentEmail;
    String message;
    String status;
    String token;

    factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        studentEmail: StudentEmail.fromJson(json["studentEmail"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
    );

    Map<dynamic, dynamic> toJson() => {
        "studentEmail": studentEmail.toJson(),
        "message": message,
        "status": status,
        "token": token,
    };
}

class StudentEmail {
    StudentEmail({
        required this.createdAt,
        required this.password,
        required this.profilePhoto,
        required this.role,
        required this.level,
        required this.addedBy,
        required this.v,
        required this.name,
        required this.id,
        required this.isAdmin,
        required this.email,
        required this.updatedAt,
    });

    DateTime createdAt;
    String password;
    ProfilePhoto profilePhoto;
    String role;
    String level;
    String addedBy;
    int v;
    String name;
    String id;
    bool isAdmin;
    String email;
    DateTime updatedAt;

    factory StudentEmail.fromJson(Map<dynamic, dynamic> json) => StudentEmail(
        createdAt: DateTime.parse(json["createdAt"]),
        password: json["password"],
        profilePhoto: ProfilePhoto.fromJson(json["profilePhoto"]),
        role: json["role"],
        level: json["level"],
        addedBy: json["addedBy"],
        v: json["__v"],
        name: json["name"],
        id: json["_id"],
        isAdmin: json["isAdmin"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "password": password,
        "profilePhoto": profilePhoto.toJson(),
        "role": role,
        "level": level,
        "addedBy": addedBy,
        "__v": v,
        "name": name,
        "_id": id,
        "isAdmin": isAdmin,
        "email": email,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class ProfilePhoto {
    ProfilePhoto({
        required this.url,
    });

    String url;

    factory ProfilePhoto.fromJson(Map<dynamic, dynamic> json) => ProfilePhoto(
        url: json["url"],
    );

    Map<dynamic, dynamic> toJson() => {
        "url": url,
    };
}
