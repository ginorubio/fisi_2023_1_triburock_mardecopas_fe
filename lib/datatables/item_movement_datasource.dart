
import 'package:almacen_web_fe/models/movement_item.dart';
import 'package:flutter/material.dart';

class ItemMovementDTS extends DataTableSource {
  final List<MovementItem> itemsMovements;
  final BuildContext context;

  ItemMovementDTS(this.itemsMovements, this.context);

  @override
  DataRow getRow(int index) {
    final movementItem = this.itemsMovements[index];
   

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(movementItem.nombre ?? "")),
      DataCell(Text(movementItem.cantidad.toString())),
      DataCell(Text(movementItem.precio.toString() )),
     
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  

  @override
  int get rowCount => itemsMovements.length;

  @override
  int get selectedRowCount => 0;
}
