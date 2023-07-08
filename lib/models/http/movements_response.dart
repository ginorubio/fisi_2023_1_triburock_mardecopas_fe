import 'dart:convert';

import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:almacen_web_fe/models/movements_inputs.dart';

class MovementsInputsResponse {
    MovementsInputsResponse({
        this.message,
        this.data,
    });

    String? message;
    List<MovementsInputs>? data;

   
   factory MovementsInputsResponse.fromJson(String str) => MovementsInputsResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsInputsResponse.fromMap(Map<String, dynamic> json) => MovementsInputsResponse(
        message: json["message"],
        data: List<MovementsInputs>.from(json["data"].map((x) => MovementsInputs.fromMap(x))),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };

}

class MovementsOutputsResponse {
    MovementsOutputsResponse({
        this.message,
        this.data,
    });

    String? message;
    List<MovementsOutputs>? data;

   
   factory MovementsOutputsResponse.fromJson(String str) => MovementsOutputsResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsOutputsResponse.fromMap(Map<String, dynamic> json) => MovementsOutputsResponse(
        message: json["message"],
        data: List<MovementsOutputs>.from(json["data"].map((x) => MovementsOutputs.fromMap(x))),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };

}
