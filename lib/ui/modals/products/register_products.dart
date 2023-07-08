import 'package:almacen_web_fe/models/category.dart';
import 'package:almacen_web_fe/models/products.dart';
import 'package:almacen_web_fe/providers/category_provider.dart';
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

class RegisterProductsModal extends StatefulWidget {
  final Products? products;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  RegisterProductsModal({
    Key? key,
    this.products,
  }) : super(key: key);

  @override
  _RegisterProductsModalState createState() => _RegisterProductsModalState();
}

class _RegisterProductsModalState extends State<RegisterProductsModal> {
  String codigo = '';
  String nombre = "";
  String descripcion = "";
  String precio = "";
  String stock = "";
  String stockMin = "";
  String costo = "";
  String categoria = "";
  String dropdownValue = "unidades";
  String dropdownValueCategory = "";
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryEnabled();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =  Provider.of<ProductsProvider>(context, listen: false);
    final categories = Provider.of<CategoryProvider>(context).categories;
    dropdownValueCategory = (categories.isEmpty) ? "" :categories[0].nombre ?? "";
    return Container(
      padding: EdgeInsets.all(0),
      
      width: 410, //
      decoration: buildBoxDecoration(),
      child: Column(
        
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Text(
              "Registrar Producto",
              style: CustomLabels.titleModals,
            ),
          ),
          Container(
                width: 700,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomInputs.customTextFieldForm(
                        (value) => codigo = value, "Código", "Ingrese el código del producto"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm((value) => nombre = value,
                        "Nombre", "Nombre del producto"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => descripcion = value, "Descripcion", "Breve descripción"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => precio = value, "Precio (S/.", " Ingrese el precio "),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => costo = value, "Costo (S/.)", "Ingrese el costo"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Unidad de medida",
                          style: TextStyle(color: CustomColor.primaryColor())
                        ),
                        Spacer(),
                        DropdownButton<String>(
                          disabledHint: Text("Unidad de medida"),
                          value: dropdownValue,
                          items: <String>['unidades', 'decenas', 'centenas', 'millares']
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

                          onChanged: (String? newValue)  {
                              setState(()  {
                              
                                  dropdownValue = newValue!;
                                });
                            
                          
                          },
                        ),
                      ],
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => stock = value, "Stock ", " 0"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => stockMin = value, "Stock Mínimo", " 0"),
                    SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      children: [
                        Text("Categorías",
                          style: TextStyle(color: CustomColor.primaryColor())
                        ),
                        Spacer(),
                        (categories.isEmpty) ? Text("Cargandoo...") :
                        DropdownButton<String>(
                          disabledHint: Text("Seleccionar la categoría"),
                          value: dropdownValueCategory,
                          items: categories 
                          .map(( value) {
                            return DropdownMenuItem<String>(
                              value: value.nombre,
                              child: Text(
                                value.nombre ?? "",
                                style: TextStyle(
                                  color: CustomColor.primaryColor(),
                                  fontSize: 16),
                              ),
                            );
                          }).toList(),

                          onChanged: (newValue)  {
                              setState(()  {
                                  dropdownValueCategory = newValue ?? "";
                                });
                            
                          
                          },
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 20),
                  child: CustomFlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: "Cancelar",
                    color: Colors.red,
                    colorText: Colors.white,
                  )),
              Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 20),
                  child: CustomFlatButton(
                    onPressed: () async {

                      if (codigo.isEmpty || stock.isEmpty ) {
                        NotificationsService.showSnackbarError('Falta ingresar datos o los ingresados no son correctos');
                      }else{
                        try {
                          Category category = categories.firstWhere((element) => element.nombre == dropdownValueCategory);
                          double costo = double.parse(this.costo);
                          double precio = double.parse(this.precio);
                          int stock = int.parse(this.stock);
                          int stock_min = int.parse(this.stockMin);
                          await productProvider.newProduct(nombre, category.id ?? 0, codigo, dropdownValue, costo, descripcion, precio, stock, stock_min);

                          NotificationsService.showSnackbar('${nombre}, Se ha registrado con exito !');
                          Navigator.of(context).pop();

                        } catch (e) {
                          Navigator.of(context).pop();
                          NotificationsService.showSnackbarError('No se pudo registrar el producto');
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
