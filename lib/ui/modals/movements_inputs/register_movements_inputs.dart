import 'package:almacen_web_fe/datatables/product_item_datasource.dart';
import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:almacen_web_fe/providers/movements_inputs_provider.dart';
import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:almacen_web_fe/providers/product_item_provider.dart';
import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:almacen_web_fe/ui/inputs/custom_form_textfield.dart';
import 'package:almacen_web_fe/ui/inputs/custom_inputs.dart';
import 'package:almacen_web_fe/ui/labels/custom_labels.dart';
import 'package:almacen_web_fe/ui/modals/products/register_product_item_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../datatables/movements_outputs_datasoource.dart';
import '../../../services/notifications_service.dart';
import '../../cards/white_card.dart';

class RegisterMovementsModal extends StatefulWidget {
  
  RegisterMovementsModal({
    Key? key, 
    
  }) : super(key: key);

  @override
  _RegisterMovementsModalState createState() => _RegisterMovementsModalState();
}

class _RegisterMovementsModalState extends State<RegisterMovementsModal> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String codigo = '';
  String  orden_compra = "";
  String fecha = "";
  String proveedor = "";

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsItemProvider>(context, listen: false).clearProductItemInputs();
  }


  @override
  Widget build(BuildContext context) {

    final productsItemInputs = Provider.of<ProductsItemProvider>(context).productsItemImputs;
    final movementsInputsProvider = Provider.of<MovementsInputsProvider>(context);
    return Container(
      padding: EdgeInsets.all(0),
      
      width: 800, // 
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Registrar Movimiento de entrada",
              style: CustomLabels.titleModals,
              ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomInputs.customTextFieldForm((value) => codigo = value, "Código", "Ingrese el código"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldForm((value) => orden_compra = value, "Orden de compra", "Orden ... "),
                    SizedBox(height: 20,),
                    CustomFlatButton(onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterProducItemInput(),
                            );
                          });
                    },
                    text: "Agregar productos", color: CustomColor.primaryColor(), colorText: Colors.white
                    )
                     
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(

                  children: [
                    CustomInputs.customTextFieldForm((value) => fecha = value, "Fecha", "aaaa-mm-dd"),
                    SizedBox(height: 20,),
                     CustomInputs.customTextFieldForm((value) => proveedor = value, "Proveedor", "Empresa ..."),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only( left: 40, right: 20, bottom: 20, top: 20),
                            child: CustomFlatButton(onPressed: () => Navigator.of(context).pop(), text: "Cancelar", color: Colors.red, colorText: Colors.white,)
                            ),
                          Container(
                            padding: EdgeInsets.only( left: 20, bottom: 20, top: 20),
                            child: CustomFlatButton(onPressed: () async {
                                if (codigo.isEmpty || orden_compra.isEmpty || proveedor.isEmpty || fecha.isEmpty || productsItemInputs.isEmpty) {
                                  NotificationsService.showSnackbarError('Falta ingresar datos o los ingresados no son correctos');
                                }else{
                                  try {
                                    
                                    await movementsInputsProvider.newMovementInput(codigo, orden_compra, fecha, proveedor, productsItemInputs);
                                    NotificationsService.showSnackbar('El movimiento ${codigo}, Se ha registrado con exito !');
                                    Navigator.of(context).pop();

                                  } catch (e) {
                                    Navigator.of(context).pop();
                                    NotificationsService.showSnackbarError('No se pudo registrar el movimiento ');
                                  }
                                }


                              },
                              text: "Guardar", color: Colors.green, colorText: Colors.white,
                              )
                            )
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
                child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Código')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Stock')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Categoria')),
                DataColumn(label: Text('Descripción')),
              ],
              source: ProductsItemDTS(productsItemInputs, context),
              header: Row(children: [
                Text('Productos'),
              ]),
              // onRowsPerPageChanged: (value) {
              //   setState(() {
              //     _rowsPerPage = value ?? 10;
              //   });
              // },
              rowsPerPage: 4,
            )),
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

