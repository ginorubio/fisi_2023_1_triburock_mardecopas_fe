import 'dart:convert';

import '../users.dart';

class UsersResponse {
  UsersResponse({
    this.message,
    this.data,
  });

  String? message;
  List<Users>? data;

  factory UsersResponse.fromJson(String str) =>
      UsersResponse.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        message: json["message"],
        data: List<Users>.from(json["data"].map((x) => Users.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
