import 'dart:convert';

class Category {
    Category({
         this.id,
        this.codigo,
        this.nombre,
        this.estado
        
    });

    int? id;
    String? codigo;
    String? nombre;
    String? estado;

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],       
        estado: json["estado"],      
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
       "estado": estado,
    };
}
