import 'package:almacen_web_fe/models/products.dart';
import 'package:almacen_web_fe/providers/products_provider.dart';
import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:almacen_web_fe/ui/inputs/custom_form_textfield.dart';
import 'package:almacen_web_fe/ui/inputs/custom_inputs.dart';
import 'package:almacen_web_fe/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../datatables/products_datasource.dart';
import '../../../services/notifications_service.dart';
import '../../cards/white_card.dart';

class EditProductsModal extends StatefulWidget {
  final Products? products;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  EditProductsModal({
    Key? key,
    this.products,
  }) : super(key: key);

  @override
  _EditProductsModalState createState() => _EditProductsModalState();
}

class _EditProductsModalState extends State<EditProductsModal> {

  String descripcion = "";
  String precio = "";
  String stock_min = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(0),
      height: 1200,
      width: 410, //
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Text(
              "Editar Producto",
              style: CustomLabels.titleModals,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomInputs.customTextFieldFormDisabled("Código", widget.products?.codigo ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                   CustomInputs.customTextFieldFormDisabled("Nombre", widget.products?.nombre ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => descripcion = value, "Descripcion", widget.products?.descripcion ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormDouble(
                        (value) => precio = value, "Precio", widget.products?.precio.toString() ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormNumber(
                        (value) => stock_min = value, "Stock mínimo", widget.products?.stock_min.toString() ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormDisabled("Stock",widget.products?.stock.toString() ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormDisabled("Costo", widget.products?.costo.toString() ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormDisabled("Categoría", widget.products?.categoria ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 40),
                  child: CustomFlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: "Cancelar",
                    color: Colors.red,
                    colorText: Colors.white,
                  )),
              Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 40),
                  child: CustomFlatButton(
                    onPressed: () async {

                      if ( descripcion.isEmpty || precio.isEmpty || stock_min.isEmpty   ) {
                        NotificationsService.showSnackbarError('Falta ingresar datos o los ingresados no son correctos');
                      }else{
                          try {
                            
                            await productProvider.updateProduct(widget.products?.id ?? 0, descripcion,
                            double.parse(precio), int.parse(stock_min));
                            NotificationsService.showSnackbar('${widget.products?.nombre ?? ""} Actualizado!');
                            Navigator.of(context).pop();

                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError('No se pudo actualizar el producto');
                          }
                      }
                         
                    },
                    text: "Guardar",
                    color: Colors.green,
                    colorText: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26)]);
}
