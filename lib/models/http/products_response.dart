import 'dart:convert';
import 'package:almacen_web_fe/models/products.dart';


class ProductsResponse {
    ProductsResponse({
        this.message,
        this.data,
    });

    String? message;
    List<Products>? data;

   factory ProductsResponse.fromJson(String str) => ProductsResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory ProductsResponse.fromMap(Map<String, dynamic> json) => ProductsResponse(
        message: json["message"],
        data: List<Products>.from(json["data"].map((x) => Products.fromMap(x))),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };

}

