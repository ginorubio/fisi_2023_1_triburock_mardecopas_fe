import 'package:almacen_web_fe/models/category.dart';

import 'package:almacen_web_fe/providers/category_provider.dart';

import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';

import 'package:almacen_web_fe/ui/inputs/custom_form_textfield.dart';

import 'package:almacen_web_fe/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/notifications_service.dart';


class RegisterCategoryModal extends StatefulWidget {

 final Category? category;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  
  RegisterCategoryModal({
    Key? key, 
      this.category,
    
  }) : super(key: key);

  @override
  _RegisterCategoryModalState createState() => _RegisterCategoryModalState();
}

class _RegisterCategoryModalState extends State<RegisterCategoryModal> {
  String codigo = '';
  String  nombre = "";
 
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(0),
      height: 350,
      width: 500, // 
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity, 
            padding: EdgeInsets.all(20),
            child: Text(
              "Registrar Categoria",
              style: CustomLabels.titleModals,
              
              ),

          ),
          Container(
              width: 400,
              padding: EdgeInsets.all(20),
              child: Column(

                children: [
                     CustomInputs.customTextFieldForm((value) => codigo = value, "Código", "código de la categoría"),
                     SizedBox(height: 20,),
                     CustomInputs.customTextFieldForm((value) => nombre = value, "Nombre", "nombre del artículo "),
                     SizedBox(height: 20,),
                     
                     
                ],
              ),
            ),    
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only( left: 40, right: 20, bottom: 40, top: 40),
              child: CustomFlatButton(onPressed: () => Navigator.of(context).pop(), text: "Cancelar", color: Colors.red, colorText: Colors.white,)
              ),

            Container(
              padding: EdgeInsets.only( left: 20, right: 40, bottom: 40, top: 40),
              child: CustomFlatButton(onPressed: () async {
                    if (codigo.isEmpty || nombre.isEmpty ) {
                      NotificationsService.showSnackbarError('Falta ingresar datos o los ingresados no son correctos');
                    }else{
                      try {
                            
                        await categoryProvider.newCategory(codigo, nombre);
                        NotificationsService.showSnackbar('${nombre}, Se ha creado con exito !');
                        Navigator.of(context).pop();

                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError('No se pudo crear la categoría');
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
