import 'dart:convert';

class MovementsOutputs {
    MovementsOutputs({
         this.id,
         this.codigo,
         this.factura,
         this.cliente,
         this.estado,

        
    });

    int? id;
    String? codigo;
    String? factura;
    String? cliente;
    String? estado;


    factory MovementsOutputs.fromJson(String str) => MovementsOutputs.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovementsOutputs.fromMap(Map<String, dynamic> json) => MovementsOutputs(
        id: json["id"],
        codigo: json["codigo"],
        factura: json["factura"],
        cliente: json["cliente"],
        estado: json["estado"],

        
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "factura": factura,
        "cliente": cliente,
        "estado": estado,
    };
}