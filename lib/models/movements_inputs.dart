import 'dart:convert';

class MovementsInputs {
    MovementsInputs({
        this.id,
         this.codigo,
         this.orden_compra,
         this.proveedor,
         this.estado,
    });

    int? id;
    String? codigo;
    String? orden_compra;
    String? proveedor;
    String? estado;

    factory MovementsInputs.fromJson(String str) => MovementsInputs.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovementsInputs.fromMap(Map<String, dynamic> json) => MovementsInputs(
        id: json["id"],
        codigo: json["codigo"],
        orden_compra: json["orden_compra"],
        proveedor: json["proveedor"],
        estado: json["estado"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "orden_compra": orden_compra,
        "proveedor": proveedor,
        "estado": estado
    };
}