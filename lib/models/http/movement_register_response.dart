

import 'dart:convert';

import '../movements_inputs.dart';
import '../movements_outputs.dart';

class MovementsInputsRegisterResponse {
    MovementsInputsRegisterResponse({
        this.message,
        this.movimiento,
    });

    String? message;
    MovementsInputs? movimiento;

   
   factory MovementsInputsRegisterResponse.fromJson(String str) => MovementsInputsRegisterResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsInputsRegisterResponse.fromMap(Map<String, dynamic> json) => MovementsInputsRegisterResponse(
        message: json["message"],
        movimiento: MovementsInputs.fromMap(json["movimiento"]),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "movimiento": movimiento!.toMap(),
    };

}

class MovementsOutputssRegisterResponse {
    MovementsOutputssRegisterResponse({
        this.message,
        this.movimiento,
    });

    String? message;
    MovementsOutputs? movimiento;

   
   factory MovementsOutputssRegisterResponse.fromJson(String str) => MovementsOutputssRegisterResponse.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

  factory MovementsOutputssRegisterResponse.fromMap(Map<String, dynamic> json) => MovementsOutputssRegisterResponse(
        message: json["message"],
        movimiento: MovementsOutputs.fromMap(json["movimiento"]),
    );


     Map<String, dynamic> toMap() => {
        "message": message,
        "movimiento": movimiento!.toMap(),
    };

}