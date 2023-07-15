import 'dart:convert';

class MovementsOutputs {
    MovementsOutputs({
         this.id,
         this.codigo,
         this.factura,
         this.cliente,
         this.estado,
        this.fecha_registro,
        
    });

    int? id;
    String? codigo;
    String? factura;
    String? cliente;
    String? estado;
    String? fecha_registro;


    factory MovementsOutputs.fromJson(String str) => MovementsOutputs.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovementsOutputs.fromMap(Map<String, dynamic> json) => MovementsOutputs(
        id: json["id"],
        codigo: json["codigo"],
        factura: json["factura"],
        cliente: json["cliente"],
        estado: json["estado"],
        fecha_registro: json["fecha_registro"].substring(0,10)

        
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "factura": factura,
        "cliente": cliente,
        "estado": estado,
        "fecha_registro": fecha_registro,
    };
}