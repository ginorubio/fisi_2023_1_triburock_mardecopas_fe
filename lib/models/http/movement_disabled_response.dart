

import 'dart:convert';

import 'package:almacen_web_fe/models/movements_inputs.dart';
import 'package:almacen_web_fe/models/movements_outputs.dart';

class MovementsInputsDisabledResponse {
    MovementsInputsDisabledResponse({
        this.message,
        this.data,
    });

    String? message;
    MovementsInputs? data;

   
   factory MovementsInputsDisabledResponse.fromJson(String str) => MovementsInputsDisabledResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsInputsDisabledResponse.fromMap(Map<String, dynamic> json) => MovementsInputsDisabledResponse(
        message: json["message"],
        data: MovementsInputs.fromMap(json["data"]),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": data!.toMap(),
    };

}

class MovementsOutputssDisabledResponse {
    MovementsOutputssDisabledResponse({
        this.message,
        this.data,
    });

    String? message;
    MovementsOutputs? data;

   
   factory MovementsOutputssDisabledResponse.fromJson(String str) => MovementsOutputssDisabledResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsOutputssDisabledResponse.fromMap(Map<String, dynamic> json) => MovementsOutputssDisabledResponse(
        message: json["message"],
        data: MovementsOutputs.fromMap(json["data"]),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": data!.toMap(),
    };

}