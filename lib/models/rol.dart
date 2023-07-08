import 'dart:convert';

class Rol {
    Rol({
         this.id_rol,
        this.name,
        
    });

    int? id_rol;
    String? name;

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id_rol: json["id_rol"],
        name: json["name"],
   
    );

    Map<String, dynamic> toMap() => {
        "id_rol": id_rol,
        "name": name,

    };
}