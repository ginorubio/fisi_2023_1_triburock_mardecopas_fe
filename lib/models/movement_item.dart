import 'dart:convert';

class  MovementItem{

    MovementItem({
        this.id,
        this.cantidad,
        this.nombre,
        this.precio
    });

    int? id;
    int? cantidad;
    String? nombre;
    double? precio;

    factory MovementItem.fromJson(String str) => MovementItem.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovementItem.fromMap(Map<String, dynamic> json) => MovementItem(
        id: json["id"],
        cantidad: json["cantidad"],
        nombre: json["nombre"],       
        precio: json["precio"],      
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "cantidad": cantidad,
        "nombre": nombre,
       "precio": precio,
    };
}
