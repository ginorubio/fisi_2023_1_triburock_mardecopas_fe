
import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:almacen_web_fe/providers/filepdf_movement_provider.dart';
import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:almacen_web_fe/services/pdf_redirect.dart';
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:almacen_web_fe/ui/modals/movements_inputs/register_movements_inputs.dart';
import 'package:almacen_web_fe/ui/modals/movements_outputs/show_movements_output.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../services/notifications_service.dart';


class MovementsDTS extends DataTableSource {

  final List<MovementsOutputs> movementsOutputs;
  final BuildContext context;

  MovementsDTS(this.movementsOutputs, this.context);


  @override
  DataRow getRow(int index) {

    final movementOutput = this.movementsOutputs[index];
     final movementOutputProvider = Provider.of<MovementsOutputsProvider>(context, listen: false);
     final pdfProvider = Provider.of<FilePdfMovementProvider>(context, listen: false);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( movementOutput.codigo ?? "" ) ),
        DataCell( Text( movementOutput.factura ?? "" ) ),
        DataCell( Text( movementOutput.cliente ?? "" ) ),
        DataCell( Text( movementOutput.fecha_registro ?? "" ) ),
        DataCell( Text( movementOutput.estado ?? "" ) ),
        DataCell( 
          Row(
            children: [
              IconButton(
                icon: Icon( Icons.remove_red_eye_sharp, color: CustomColor.infoColor().withOpacity(0.8) ),
                onPressed: () {
                      movementOutputProvider.clearItemsMovementsOutputs();
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: ShowMovementsOutputsModal(movementOutput: movementOutput),
                            );
                          });
                    },
              ),
              /*
               IconButton(
                 icon: Icon( Icons.download, color: CustomColor.infoColor().withOpacity(0.8) ),
                  onPressed: () async {
                  
                  try {
                      
                      final pdfNewBytes = await pdfProvider.getReporteMovimientoPorID(movementOutput.codigo ?? "");
                      
                      PDFredirectUtility.openPDFInNewTab(pdfNewBytes);

                      NotificationsService.showSnackbar('Se descargo el reporte de movimiento de ${movementOutput.codigo} !');

                  } catch (e) {
                      NotificationsService.showSnackbarError('No se pudo obtener el reporte de movimiento');
                  }
                 }
               ),*/
              (movementOutput.estado == 'Aprobado')
              ? IconButton(
                icon: Icon( Icons.cancel, color: Colors.red.withOpacity(0.8) ),
                onPressed: () {

                    final dialog = AlertDialog(
                    title: Icon(Icons.dangerous_sharp, color: Colors.red, size: 40),
                    content: Text('¿Desea Anular el movimiento ${movementOutput.codigo}?'),
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
                            
                            await movementOutputProvider..disabledMovementOutput(movementOutput.id ?? 0);
                            NotificationsService.showSnackbar('${movementOutput.codigo} Inhabilitado!');
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
  int get rowCount => movementsOutputs.length;

  @override

  int get selectedRowCount => 0;

}