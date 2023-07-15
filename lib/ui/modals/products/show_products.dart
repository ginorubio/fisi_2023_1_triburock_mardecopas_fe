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
import '../../cards/white_card.dart';

class ShowProductsModal extends StatefulWidget {
  final Products? products;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  ShowProductsModal({
    Key? key,
    this.products,
  }) : super(key: key);

  @override
  _ShowProductsModalState createState() => _ShowProductsModalState();
}

class _ShowProductsModalState extends State<ShowProductsModal> {
  String codigo = '';
  String nombre = "";
  String descripcion = "";
  String precio = "";
  String stock = "";
  String stockMin = "";
  String costo = "";
  String categoria = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context, listen: false);

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
              "Ver Producto",
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
                    CustomInputs.customTextFieldForm(
                        (value) => codigo = value, "Código", ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => nombre = value, "Nombre", ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => descripcion = value, "Descripcion", " "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => precio = value, "Precio", " "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => stock = value, "Stock", " "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => stockMin = value, "Stock Mínimo", " "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => costo = value, "Costo", " "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => categoria = value, "Categoría", " "),
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
                    onPressed: () {
                      print(codigo);
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
