

import 'package:almacen_web_fe/models/product_item.dart';
import 'package:almacen_web_fe/models/products.dart';
import 'package:almacen_web_fe/providers/product_item_provider.dart';
import 'package:almacen_web_fe/providers/products_provider.dart';
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/notifications_service.dart';
import '../../buttons/custom_flatButton.dart';
import '../../inputs/custom_form_textfield.dart';
import '../../labels/custom_labels.dart';

class RegisterProducItemInput extends StatefulWidget {
  
  RegisterProducItemInput({
    Key? key, 
    
  }) : super(key: key);

  @override
  State<RegisterProducItemInput> createState() => _RegisterProducItemInputState();
}

class _RegisterProducItemInputState extends State<RegisterProducItemInput> {
  String codigo_product = ' ';
  String   name_product = " ";
  String description = ' ';
  String   categoria = " ";
  String stock = '0';
  String   precio = "0.0";
  String   cantidad = "0";
  Products product = Products();
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

  final productProvider = Provider.of<ProductsProvider>(context, listen: false);
  final productsItemProvider = Provider.of<ProductsItemProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(0),
      height: 400,
      width: 800, // 
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
           Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Agregar Producto",
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
                     CustomInputs.customTextFieldForm((value) => codigo_product = value, "Código", "Ingrese el código"),
                     SizedBox(height: 30,),
                     CustomInputs.customTextFieldFormDisabled("Nommbre ", product.nombre ?? ""),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Stock (${product.unidad_medida})", product.stock.toString()),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Categoría", product.categoria ?? ""),
                     
                  ],
                ),
              ),
              Container(
                width: 400,
                
                padding: EdgeInsets.only( left: 20, right: 20, bottom: 0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(  bottom: 20),
                      child: CustomFlatButton(onPressed: () async{
                          try{
                            final productValue = await productProvider.getProductItemForCode(codigo_product);
                             setState(()  {
                                this.product = productValue;
                              });
                          }catch (e){
                            NotificationsService.showSnackbarError('No se encontro el producto de código: $codigo_product');
                            setState(()  {
                                this.product = Products();
                              });
                          }
                          
                         
                          
                        },
                        text: "Buscar", color: CustomColor.primaryColor(), colorText: Colors.white,
                        )
                      ),
                    CustomInputs.customTextFieldFormDisabled("Descripción", product.descripcion ?? ""),
                    SizedBox(height: 20,),
                    CustomInputs.customTextFieldFormDisabled("Precio (S/.) ", product.precio.toString()),
                    SizedBox(height: 20,),
                     CustomInputs.customTextFieldForm((value) => cantidad = value, "Cantidad", "Ingrese la cantidad"),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only( left: 40, right: 20, bottom: 20, top: 40),
                child: CustomFlatButton(onPressed: () => Navigator.of(context).pop(), text: "Cancelar", color: Colors.red, colorText: Colors.white,)
                ),
              Container(
                padding: EdgeInsets.only( left: 20, bottom: 20, top: 40, right: 20),
                child: CustomFlatButton(onPressed: () {
                    final cantidadParse = int.parse(cantidad);
                    final productItem = ProductItem(
                      codigo_product: codigo_product, 
                      name_product: product.nombre, 
                      description: product.descripcion, 
                      categoria: product.categoria,
                      stock: product.stock ?? 0,
                      precio: product.precio ?? 0.0,
                      cantidad: int.parse(cantidad) 

                       );
                      productsItemProvider.addItemMovementInput(productItem);
                      Navigator.of(context).pop();
                  },
                  text: "Agregar", color: Colors.green, colorText: Colors.white,
                  )
                )
            ],
          )

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
