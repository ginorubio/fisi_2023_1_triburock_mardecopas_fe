


import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../datatables/item_movement_datasource.dart';
import '../../buttons/custom_flatButton.dart';
import '../../cards/white_card.dart';
import '../../design/custom_colors.dart';
import '../../inputs/custom_form_textfield.dart';
import '../../labels/custom_labels.dart';

class ShowMovementsOutputsModal extends StatefulWidget {
  
  final MovementsOutputs movementOutput;
  ShowMovementsOutputsModal({
    Key? key, 
    required this.movementOutput,
  }) : super(key: key);

  @override
  _ShowMovementsOutputsModalState createState() => _ShowMovementsOutputsModalState();
}

class _ShowMovementsOutputsModalState extends State<ShowMovementsOutputsModal> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<MovementsOutputsProvider>(context, listen: false).getItemsMovementsOutputsForID(widget.movementOutput.id ?? 0);
  }


  @override
  Widget build(BuildContext context) {
    final sizeGlobal = MediaQuery.of(context).size;
    final itemsMovementsOutputs = Provider.of<MovementsOutputsProvider>(context).itemsMovementsOutputs;
    return Container(
      padding: EdgeInsets.all(0),
      
      width: (sizeGlobal.width > 1050) ? 800: 450, /// 
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Detalle Movimiento de salida",
              style: CustomLabels.titleModals,
              ),
          ),
          (sizeGlobal.width > 1050)
          ?
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomInputs.customTextFieldFormDisabled("Código :", "${widget.movementOutput.codigo}"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldFormDisabled("Factura :", "${widget.movementOutput.factura}"),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(

                  children: [
                    
                    CustomInputs.customTextFieldFormDisabled("Fecha :", "${widget.movementOutput.fecha_registro}"),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Cliente :", "${widget.movementOutput.cliente}"),
                   
                  ],
                ),
              )
            ],
          )
          :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomInputs.customTextFieldFormDisabled("Código :", "${widget.movementOutput.codigo}"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldFormDisabled("Factura :", "${widget.movementOutput.factura}"),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(

                  children: [
                    
                    CustomInputs.customTextFieldFormDisabled("Fecha :", "${widget.movementOutput.fecha_registro}"),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Cliente :", "${widget.movementOutput.cliente}"),
                   
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
                child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Precio (S/.)')),
                DataColumn(label: Text('Total (S/.)')),
              ],
              source: ItemMovementDTS(itemsMovementsOutputs, context),
              header: Row(children: [
                Text('Productos'),
              ]),
              rowsPerPage: 4,
            )),
          ),
        Container(
          margin: EdgeInsets.all(20),
          child: CustomFlatButton(
            
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: "Cerrar", color: CustomColor.primaryColor(), colorText: Colors.white,
            ),
        ),
        ],
      ),
    );
  }


  BoxDecoration buildBoxDecoration() => BoxDecoration(
    
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}
