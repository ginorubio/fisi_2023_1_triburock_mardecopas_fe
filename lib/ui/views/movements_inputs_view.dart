import 'package:almacen_web_fe/datatables/movements_outputs_datasoource.dart';
import 'package:almacen_web_fe/datatables/movements_inputs_datasource.dart';
import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:almacen_web_fe/models/movements_inputs.dart';
import 'package:almacen_web_fe/providers/movements_inputs_provider.dart';
import 'package:almacen_web_fe/services/notifications_service.dart';
import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/cards/white_card.dart';
import 'package:almacen_web_fe/ui/design/custom_decoration.dart';
import 'package:almacen_web_fe/ui/modals/movements_inputs/register_movements_inputs.dart';
import 'package:almacen_web_fe/ui/shared/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/custom_colors.dart';
import '../inputs/custom_form_textfield.dart';

class MovemenentsInputsView extends StatefulWidget {
  @override
  State<MovemenentsInputsView> createState() => _MovemenentsInputsViewState();
}

class _MovemenentsInputsViewState extends State<MovemenentsInputsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String dropdownValue = 'Aprobados';

  @override
  void initState() {
    super.initState();
    Provider.of<MovementsInputsProvider>(context, listen: false).getMovementsInputsEnabled();
  }

  @override
  Widget build(BuildContext context) {
    final sizeGlobal = MediaQuery.of(context).size;
    final movementsInputs = Provider.of<MovementsInputsProvider>(context).movementsInputs;
    final movementsInputsProvider  = Provider.of<MovementsInputsProvider>(context, listen: false);
    String searchValue = "";
    return Container(
      color: Colors.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Movimientos de Ingresos"),
          Container(
            padding: (sizeGlobal.width > 950) ? EdgeInsets.only(bottom: 20) : EdgeInsets.only(left: 20) ,
            decoration: CustomBoxDecoration.navBoxDecoration(),
            child: 
            (sizeGlobal.width > 950)
            ?
            Row(
              children: [
                SizedBox(width: 40),
                CustomInputs.customTextFieldFormSearch((value) => searchValue = value,  "buscar por código"),
                SizedBox(width: 15),
                CustomFlatButton(
                    onPressed: () async {

                      if (searchValue.isEmpty){
                        NotificationsService.showSnackbarError("Ingrese el código del Movimiento para realizar la búsqueda");
                      }else{
                        await movementsInputsProvider.getMovementsInputsForCode(searchValue);
                      }
                        
                    },
                    text: "Buscar",
                    color: Colors.white,
                    colorText: Colors.black
                    
                ),
                Spacer(),
                CustomFlatButton(
                    onPressed: () {
                      print("DidTap Nuevo movimientos");
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterMovementsModal(),
                            );
                          });
                    },
                    text: "Nuevo",
                    color: Colors.white,
                    colorText: Colors.black),
                SizedBox(width: 44)
              ],
            )
            :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                CustomInputs.customTextFieldFormSearch((value) => searchValue = value,  "buscar por código"),
                SizedBox(height: 15),
                CustomFlatButton(
                    onPressed: () async {

                      if (searchValue.isEmpty){
                        NotificationsService.showSnackbarError("Ingrese el código del Movimiento para realizar la búsqueda");
                      }else{
                        await movementsInputsProvider.getMovementsInputsForCode(searchValue);
                      }
                        
                    },
                    text: "Buscar",
                    color: Colors.white,
                    colorText: Colors.black
                    
                ),
                SizedBox(height: 15),
                CustomFlatButton(
                    onPressed: () {
                      print("DidTap Nuevo movimientos");
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterMovementsModal(),
                            );
                          });
                    },
                    text: "Nuevo",
                    color: Colors.white,
                    colorText: Colors.black),
                SizedBox(height: 15),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
                child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Código')),
                DataColumn(label: Text('Orden de compra')),
                DataColumn(label: Text('Proveedor')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Acciones'))
              ],
              source: MovementsInputsDTS(movementsInputs, context),
               header: Row(children: [
                Text('Movimientos de Entrada' ),
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
                        await movementsInputsProvider.getMovementsInputsEnabled();
                        
                    } else {
                      // inhabilitados
                        await movementsInputsProvider.getMovementsInputsDisabled();
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
            )),
          )
        ],
      ),
    );
  }


  
}
