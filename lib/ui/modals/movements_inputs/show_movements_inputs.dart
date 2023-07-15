import 'package:almacen_web_fe/datatables/item_movement_datasource.dart';
import 'package:almacen_web_fe/models/movement_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/movements_inputs.dart';
import '../../../providers/movements_inputs_provider.dart';
import '../../buttons/custom_flatButton.dart';
import '../../cards/white_card.dart';
import '../../design/custom_colors.dart';
import '../../inputs/custom_form_textfield.dart';
import '../../labels/custom_labels.dart';


class ShowMovementsInputsModal extends StatefulWidget {
  
  final MovementsInputs movementInput;
  ShowMovementsInputsModal({
    Key? key, 
    required this.movementInput,
  }) : super(key: key);

  @override
  _ShowMovementsInputsModalState createState() => _ShowMovementsInputsModalState();
}

class _ShowMovementsInputsModalState extends State<ShowMovementsInputsModal> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<MovementsInputsProvider>(context, listen: false).getItemsMovementsInputsForID(widget.movementInput.id ?? 0);
  }


  @override
  Widget build(BuildContext context) {
    final sizeGlobal = MediaQuery.of(context).size;
    final itemsMovementsInputs = Provider.of<MovementsInputsProvider>(context).itemsMovementsInputs;
    return Container(
      padding: EdgeInsets.all(0),
      
      width: (sizeGlobal.width > 1050) ? 800: 450, 
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Detalle Movimiento de entrada",
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
                     CustomInputs.customTextFieldFormDisabled("Código :", "${widget.movementInput.codigo}"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldFormDisabled("Orden de compra :", "${widget.movementInput.orden_compra}"),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(

                  children: [
                    
                    CustomInputs.customTextFieldFormDisabled("Fecha :", "${widget.movementInput.fecha_registro}"),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Proveedor :", "${widget.movementInput.proveedor}"),
                   
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
                     CustomInputs.customTextFieldFormDisabled("Código :", "${widget.movementInput.codigo}"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldFormDisabled("Orden de compra :", "${widget.movementInput.orden_compra}"),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(

                  children: [
                    
                    CustomInputs.customTextFieldFormDisabled("Fecha :", "${widget.movementInput.fecha_registro}"),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Proveedor :", "${widget.movementInput.proveedor}"),
                   
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
              source: ItemMovementDTS(itemsMovementsInputs, context),
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
