
import 'package:almacen_web_fe/models/category.dart';
import 'package:almacen_web_fe/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notifications_service.dart';



class CategoryDTS extends DataTableSource {

  final List<Category> categories;
  final BuildContext context;

  CategoryDTS(this.categories, this.context);


  @override
  DataRow getRow(int index) {

    final category = this.categories[index];
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( category.id.toString() ) ),
        DataCell( Text( category.codigo ?? '') ),
        DataCell( Text( category.nombre ?? '') ),
        DataCell( 
          Row(
            children: [

              (category.estado == 'habilitado') 
              ? IconButton(
                icon: Icon( Icons.arrow_downward_rounded, color: Colors.red.withOpacity(0.8) ),
                onPressed: () {

                    final dialogInhabilitar = AlertDialog(
                    title: Icon(Icons.arrow_downward_rounded, color: Colors.green, size: 40,),
                    // alignment: Alignment.center,
                    content: Text('¿Desea inhabilitar la categoria ${category.nombre }?'),
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
                            
                            await categoryProvider.disabledCategory(category.id ?? 0);
                            NotificationsService.showSnackbar('${category.nombre} Inhabilitado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo inhabilitar la categoría');
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
                    content: Text('¿Desea Habilitar la categoria ${category.nombre }?'),
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
                            
                            await categoryProvider.enabledCategory(category.id ?? 0);
                            NotificationsService.showSnackbar('${category.nombre} habilitado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo habilitar la categoría');
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
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override

  int get selectedRowCount => 0;

}