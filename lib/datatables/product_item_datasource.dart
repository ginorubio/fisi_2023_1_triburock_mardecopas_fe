
import 'package:almacen_web_fe/models/product_item.dart';
import 'package:flutter/material.dart';

class ProductsItemDTS extends DataTableSource {
  final List<ProductItem> products;
  final BuildContext context;

  ProductsItemDTS(this.products, this.context);

  @override
  DataRow getRow(int index) {
    final productItem = this.products[index];
   

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(productItem.codigo_product ?? "")),
      DataCell(Text(productItem.name_product ?? "")),
      DataCell(Text(productItem.cantidad.toString() )),
      DataCell(Text(productItem.stock.toString())),
      DataCell(Text(productItem.precio.toString())),
      DataCell(Text(productItem.categoria ?? "")),
      DataCell(Text(productItem.description ?? "")),
     
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
