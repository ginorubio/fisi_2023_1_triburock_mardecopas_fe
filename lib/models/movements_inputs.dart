import 'dart:convert';

class MovementsInputs {
    MovementsInputs({
        this.id,
         this.codigo,
         this.orden_compra,
         this.proveedor,
         this.estado,
         this.fecha_registro,
    });

    int? id;
    String? codigo;
    String? orden_compra;
    String? proveedor;
    String? estado;
    String? fecha_registro;

    factory MovementsInputs.fromJson(String str) => MovementsInputs.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovementsInputs.fromMap(Map<String, dynamic> json) => MovementsInputs(
        id: json["id"],
        codigo: json["codigo"],
        orden_compra: json["orden_compra"],
        proveedor: json["proveedor"],
        estado: json["estado"],
        fecha_registro: json["fecha_registro"].substring(0,10)
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "orden_compra": orden_compra,
        "proveedor": proveedor,
        "estado": estado,
        "fecha_registro": fecha_registro
    };
}