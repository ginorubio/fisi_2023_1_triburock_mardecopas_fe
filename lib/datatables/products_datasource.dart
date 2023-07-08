import 'package:almacen_web_fe/models/products.dart';
import 'package:almacen_web_fe/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notifications_service.dart';
import '../ui/modals/products/edit_products.dart';
import '../ui/modals/products/show_products.dart';

class ProductsDTS extends DataTableSource {
  final List<Products> products;
  final BuildContext context;

  ProductsDTS(this.products, this.context);

  @override
  DataRow getRow(int index) {
    final products = this.products[index];
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(products.codigo ?? "")),
      DataCell(Text(products.nombre ?? "")),
      DataCell(Text(products.precio.toString())),
      DataCell(Text(products.costo.toString())),
      DataCell(Text(products.stock.toString())),
      DataCell(Text(products.stock_min.toString())),
      DataCell(Text(products.categoria ?? "")),
      DataCell(Text(products.descripcion ?? "")),
      DataCell(Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.green,
                size: 25,
              ),
              onPressed: () {
                print("Presionando Edit");
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: EditProductsModal(products: products),
                      );
                    });
              }),
          (products.estado == 'habilitado') 
              ? IconButton(
                icon: Icon( Icons.arrow_downward_rounded, color: Colors.red.withOpacity(0.8) ),
                onPressed: () {

                    final dialogInhabilitar = AlertDialog(
                    title: Icon(Icons.arrow_downward_rounded, color: Colors.green, size: 40,),
                    // alignment: Alignment.center,
                    content: Text('¿Desea inhabilitar el producto ${products.nombre }?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      
                      TextButton(
                        child: Text('Inhabilitar'),
                        onPressed: () async {
                         
                          try {
                            
                            await productProvider.disabledProduct(products.id ?? 0 );
                            NotificationsService.showSnackbar('${products.nombre} Inhabilitado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo inhabilitar el producto');
                          }

                        },
                      ),
                    ],
                  );

                  

                  showDialog(
                    context: context, 
                    builder: ( _ ) =>  dialogInhabilitar 
                  );

                }
              )
              : IconButton(
                icon: Icon( Icons.arrow_upward_rounded, color: Colors.blue.withOpacity(0.8) ),
                onPressed: () {

                  
                    final dialogHabilitar = AlertDialog(
                    title: Icon(Icons.arrow_upward_rounded, color: Colors.blue, size: 40,),
                    // alignment: Alignment.center,
                    content: Text('¿Desea Habilitar el producto ${products.nombre }?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      
                      TextButton(
                        child: Text('Habilitar'),
                        onPressed: () async {
                         //PEgar al servicio eliminar
                        try {
                            
                            await productProvider.enabledProduct(products.id ?? 0);
                            NotificationsService.showSnackbar('${products.nombre} habilitado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo habilitar el producto');
                          }
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) =>  dialogHabilitar
                  );

                }
              )
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
