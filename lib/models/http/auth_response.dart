import 'dart:convert';

class AuthResponse {
    AuthResponse({
         this.id,
         this.rol_id, 
         this.fullname,
         this.token,
         this.message
    });

    int? id;
    int? rol_id;
    String? fullname;
    String? token;
    String? message;

    factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        id: json["id"],
        rol_id: json["rol_id"],
        fullname: json["nombre"],  
        token: json["token"],   
        message: json["message"],  
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "rol_id": rol_id,
        "nombre": fullname,
        "token": token,
        "message": message
    };
}
