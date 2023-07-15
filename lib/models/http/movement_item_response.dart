
import 'package:almacen_web_fe/models/movement_item.dart';
import 'package:flutter/material.dart';
import 'dart:convert';



class MovementItemResponse {
    MovementItemResponse({
        this.message,
        this.data,
    });

    String? message;
    List<MovementItem>? data;

   
   factory MovementItemResponse.fromJson(String str) => MovementItemResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementItemResponse.fromMap(Map<String, dynamic> json) => MovementItemResponse(
        message: json["message"],
        data: List<MovementItem>.from(json["data"].map((x) => MovementItem.fromMap(x))),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };

}

