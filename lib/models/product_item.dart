import 'dart:convert';

class ProductItem {
  ProductItem(
      { 
      this.codigo_product,
       this.name_product,
       this.description,
       this.categoria,
       this.stock,
       this.precio,
       this.cantidad
      }

      );

  String? codigo_product;
  String? name_product;
  String? description;
  String? categoria; 
  int? stock;
  double? precio;
  int? cantidad;

  factory ProductItem.fromJson(String str) => ProductItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductItem.fromMap(Map<String, dynamic> json) => ProductItem(
        codigo_product: json["codigo_product"],
        name_product: json["name_product"],
        description: json["description"],
        categoria: json["categoria"],
        stock: json["stock"],
        precio: json["precio"],
        cantidad: json["cantidad"],

      );

  Map<String, dynamic> toMap() => {
        "codigo_product": codigo_product,
        "name_product": name_product,
        "description": description,
        "categoria": categoria,
        "stock": stock,
        "precio": precio,
        "cantidad": cantidad,
      };
}
