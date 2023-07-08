import 'package:almacen_web_fe/models/movements_inputs.dart';
import 'package:almacen_web_fe/providers/movements_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notifications_service.dart';
import '../ui/design/custom_colors.dart';

class MovementsInputsDTS extends DataTableSource {

  final List<MovementsInputs> movementsInputs;
  final BuildContext context;

  MovementsInputsDTS(this.movementsInputs, this.context);


  @override
  DataRow getRow(int index) {

    final movementInput = this.movementsInputs[index];
     final movementIntputProvider = Provider.of<MovementsInputsProvider>(context, listen: false);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( movementInput.codigo ??"") ),
        DataCell( Text( movementInput.orden_compra ?? "" ) ),
        DataCell( Text( movementInput.proveedor ?? "" ) ),
        DataCell( Text( movementInput.estado ?? "" ) ),
        DataCell( 
          Row(
            children: [
              // IconButton(
              //   icon: Icon( Icons.remove_red_eye_sharp, color: CustomColor.infoColor().withOpacity(0.8) ),
              //   onPressed: () {
                 
              //   }
              // ),
              (movementInput.estado == 'Aprobado')
              ? IconButton(
                icon: Icon( Icons.cancel, color: Colors.red.withOpacity(0.8) ),
                onPressed: () {

                    final dialog = AlertDialog(
                    title: Icon(Icons.dangerous_sharp, color: Colors.red, size: 40,),
                    content: Text('¿Desea Anular el movimiento ${movementInput.codigo}?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Anular'),
                        onPressed: () async {
                         //PEgar al servicio eliminar
                        try {
                            
                            await movementIntputProvider.disabledMovementInput(movementInput.id ?? 0);
                            NotificationsService.showSnackbar('${movementInput.codigo} Inhabilitado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo inhabilitar el movimiento');
                          }
                          
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog 
                  );

                }
              ): SizedBox(height: 0),
      
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => movementsInputs.length;

  @override

  int get selectedRowCount => 0;

}