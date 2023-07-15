
import 'package:almacen_web_fe/datatables/movements_outputs_datasoource.dart';
import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:almacen_web_fe/services/notifications_service.dart';
import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/cards/white_card.dart';
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:almacen_web_fe/ui/design/custom_decoration.dart';
import 'package:almacen_web_fe/ui/modals/movements_inputs/register_movements_inputs.dart';
import 'package:almacen_web_fe/ui/modals/movements_outputs/register_movements_outputs.dart';
import 'package:almacen_web_fe/ui/shared/navbar.dart';
import 'package:almacen_web_fe/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../inputs/custom_form_textfield.dart';

class MovemenentsOutputsView extends StatefulWidget {

  @override
  State<MovemenentsOutputsView> createState() => _MovemenentsOutputsViewState();
}

class _MovemenentsOutputsViewState extends State<MovemenentsOutputsView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String dropdownValue = 'Aprobados';
  @override
  void initState() {
    super.initState();

    Provider.of<MovementsOutputsProvider>(context, listen: false).getMovementsOutputsEnabled();

  }


  @override
  Widget build(BuildContext context) {

  final movementsOutputs = Provider.of<MovementsOutputsProvider>(context).movementsOutputs;
  final movementsOutputsProvider  = Provider.of<MovementsOutputsProvider>(context, listen: false);
    String searchValue = "";

    return Container(
      color: Colors.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Movimientos de Salida"),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            decoration: CustomBoxDecoration.navBoxDecoration(),
            child: Row(
              children: [
                SizedBox(width: 40),
                 CustomInputs.customTextFieldFormSearch((value) => searchValue = value,  "buscar por código"),
                SizedBox(width: 15),
                CustomFlatButton(
                  onPressed: () async {
                     if (searchValue.isEmpty){
                        NotificationsService.showSnackbarError("Ingrese el código del Movimiento para realizar la búsqueda");
                      }else{
                         await movementsOutputsProvider.getMovementsOutputsForCode(searchValue);
                      }
                    
                  }
                , text: "Buscar" , color: Colors.white,colorText: Colors.black),
                Spacer(),
                CustomFlatButton(onPressed: () {
                  print("Tap Nuevo movimientos");
                  showDialog(
                    context: context, 
                    builder: ( _ ) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: RegisterMovementsOutputs(),
                      );
                    }
                    );
                }
                , text: "Nuevo",color: Colors.white,colorText: Colors.black),
                SizedBox(width: 44)
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
              child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Código')),
                DataColumn(label: Text('Factura')),
                DataColumn(label: Text('Cliente')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Acciones'))
              ], 
              source: MovementsDTS(movementsOutputs, context),
              header: Row(children: [
                Text('Movimientos de Salida' ),
                Spacer(),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['Aprobados', 'Desaprobados']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: CustomColor.primaryColor(),
                          fontSize: 16),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) async {

                    if( newValue == 'Aprobados' ) {
                        // Habilitados
                        await movementsOutputsProvider.getMovementsOutputsEnabled();
                        
                    } else {
                      // inhabilitados
                        await movementsOutputsProvider.getMovementsOutputsDisabled();
                    }

                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
                SizedBox(width: 20,)
              ]),
              //Termina el header
              onRowsPerPageChanged: ( value ) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              
            )
            ),
          )

        ],
      ),
    );
  }
}