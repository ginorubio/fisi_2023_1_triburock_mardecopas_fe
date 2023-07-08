import 'dart:convert';

class Products {
  Products(
      { this.id,
       this.nombre,
       this.codigo,
       this.descripcion,
       this.unidad_medida,
       this.categoria,
       this.precio,
       this.costo,
       this.stock_min,
       this.stock,
      
       this.estado
      }
      );

  int? id;
  String? nombre;
  String? codigo;
  String? descripcion;
  String? unidad_medida; 
  String? categoria;
  double? precio;
  double? costo;
  int? stock_min;
  int? stock;
  String? estado;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["id"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        unidad_medida: json["unidad_medida"],
        categoria: json["categoria"],
        precio: json["precio"],
        costo: json["costo"],
        stock_min: json["stock_min"],
        stock: json["stock"],
        
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
        "descripcion": descripcion,
        "unidad_medida": unidad_medida,
        "categoria_display": categoria,
        "precio": precio,
        "costo": costo,
        "stock_min": stock_min,
        "stock": stock,
        "estado": estado,
      };
}
