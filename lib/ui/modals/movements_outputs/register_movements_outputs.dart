import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:almacen_web_fe/ui/modals/products/register_product_item_output.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../datatables/product_item_datasource.dart';
import '../../../providers/product_item_provider.dart';
import '../../../services/notifications_service.dart';
import '../../buttons/custom_flatButton.dart';
import '../../cards/white_card.dart';
import '../../design/custom_colors.dart';
import '../../inputs/custom_form_textfield.dart';
import '../../labels/custom_labels.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RegisterMovementsOutputs extends StatefulWidget {
   RegisterMovementsOutputs({
    Key? key, 
    
  }) : super(key: key);


  @override
  State<RegisterMovementsOutputs> createState() => _RegisterMovementsOutputsState();
}

class _RegisterMovementsOutputsState extends State<RegisterMovementsOutputs> {
 int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String codigo = '';
  String  factura = "";
  String fecha = "";
  String cliente = "";
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsItemProvider>(context, listen: false).clearProductItemOutputs();
  }


  @override
  Widget build(BuildContext context) {

    final productsItemOutputs = Provider.of<ProductsItemProvider>(context).productsItemOutputs;
    final movementsOutputProvider = Provider.of<MovementsOutputsProvider>(context);
    return Container(
      padding: EdgeInsets.all(0),
      
      width: 800, // 
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Registrar Movimiento de salida",
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
                     CustomInputs.customTextFieldForm((value) => factura = value, "Factura", "Ingresa tu factura "),
                    SizedBox(height: 20,),
                    CustomFlatButton(onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterProductIntemOutput(),
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
                     Row(
                      children: [
                        Text('Fecha : ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
                        IconButton(onPressed: ()  {
                          DatePicker.showDatePicker(
                            
                            context,
                            showTitleActions: true,
                            minTime: DateTime(2000),
                            maxTime: DateTime(2030),
                            onConfirm: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            currentTime: selectedDate,
                            locale: LocaleType.es,
                          );
                        }
                        , icon: Icon(Icons.calendar_today))
                      ],
                    ),
                    //CustomInputs.customTextFieldForm((value) => fecha = value, "Fecha", "AAAA-MM-dd"),
                    SizedBox(height: 20,),
                     CustomInputs.customTextFieldForm((value) => cliente = value, "Cliente", "Ingrese su nombre"),
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
                                if (codigo.isEmpty || factura.isEmpty || cliente.isEmpty || productsItemOutputs.isEmpty ) {
                                  NotificationsService.showSnackbarError('Falta ingresar datos o los ingresados no son correctos');
                                }else{
                                  try {
                                    final fechaResult = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                    await movementsOutputProvider.newMovementOutput(codigo, factura, fechaResult, cliente, productsItemOutputs);
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
              source: ProductsItemDTS(productsItemOutputs, context),
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