import 'package:flutter/material.dart';
import 'dart:convert';

import '../category.dart';


class CategoryConsultResponse {
    CategoryConsultResponse({
        this.message,
        this.data,
    });

    String? message;
    List<Category>? data;

   
   factory CategoryConsultResponse.fromJson(String str) => CategoryConsultResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory CategoryConsultResponse.fromMap(Map<String, dynamic> json) => CategoryConsultResponse(
        message: json["message"],
        data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };

}

