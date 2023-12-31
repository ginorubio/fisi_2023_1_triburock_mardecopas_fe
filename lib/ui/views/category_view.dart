

 
import 'package:almacen_web_fe/datatables/category_datasource.dart';
import 'package:almacen_web_fe/providers/category_provider.dart';
import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/cards/white_card.dart';
import 'package:almacen_web_fe/ui/design/custom_decoration.dart';
import 'package:almacen_web_fe/ui/modals/category/register_category.dart';

import 'package:almacen_web_fe/ui/shared/navbar.dart';
import 'package:almacen_web_fe/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../design/custom_colors.dart';
import '../inputs/custom_form_textfield.dart';

class CategoryView extends StatefulWidget {

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String dropdownValue = 'Habilitados';
  @override
  void initState() {
    super.initState();

    Provider.of<CategoryProvider>(context, listen: false).getCategoryEnabled();

  }


  @override
  Widget build(BuildContext context) {
  final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
  final categories = Provider.of<CategoryProvider>(context).categories;
  String searchValue = "";

    return Container(
      color: Colors.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Categoria"),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            decoration: CustomBoxDecoration.navBoxDecoration(),
            child: Row(
              children: [
                SizedBox(width: 40),
                CustomInputs.customTextFieldFormSearch((value) => searchValue = value,  "buscar por código"),
                SizedBox(width: 15),
                CustomFlatButton(
                  onPressed: () async {

                       await categoryProvider.geCategoryForCode(searchValue);
                    },
                 text: "Buscar" ,
                  color: Colors.white,
                  colorText: Colors.black
                  ),

                Spacer(),
                CustomFlatButton(onPressed: () {
                  print("Tap Nueva Categoria");
                  showDialog(
                    context: context, 
                    builder: ( _ ) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: RegisterCategoryModal(category: null),
                      );
                    }
                    );
                }
                , text: "Nuevo",color: Colors.white,colorText: Colors.black),
                
                SizedBox(width: 44)
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
              child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Codigo')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Acciones'))                
              ], 
              source: CategoryDTS(categories, context),
              header:  Row(children: [
                Text('Categorias' ),
                Spacer(),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['Habilitados', 'Inhabilitados']
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

                  onChanged: (String? newValue)  async{
                      if( newValue == 'Habilitados' ) {
                        // Habilitados
                        await categoryProvider.getCategoryEnabled();
                         setState(()  {
                      
                          dropdownValue = newValue!;
                        });
                      } else {
                        // inhabilitados
                        await categoryProvider.getCategoryDiseabled();
                        setState(()  {
                      
                          dropdownValue = newValue!;
                        });
                      }
                     
                   
                  },
                ),
                SizedBox(width: 20,)
              ]),
              onRowsPerPageChanged: ( value ) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              
            )
            ),
          )

        ],
      ),
    );
  }
}