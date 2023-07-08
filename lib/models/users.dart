import 'dart:convert';

class Users {
  Users(
      {this.id,
      this.rol,
      this.rol_display,
      this.username,
      this.email,
      this.password,
      this.direccion,
      this.telefono,
      this.dni,
      this.estado});

  int? id;
  int? rol;
  String? rol_display;
  String? username;
  String? email;
  String? password;
  String? direccion;
  String? telefono;
  String? dni;
  String? estado;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        rol: json["rol"],
        rol_display: json["rol_display"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        dni: json["dni"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rol": rol,
        "rol_display": rol_display,
        "username": username,
        "email": email,
        "password": password,
        "direccion": direccion,
        "telefono": telefono,
        "dni": dni,
        "estado": estado
      };
}
