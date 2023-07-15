import 'package:almacen_web_fe/ui/inputs/custom_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../datatables/products_datasource.dart';
import '../../providers/products_provider.dart';
import '../../services/notifications_service.dart';
import '../buttons/custom_flatButton.dart';
import '../cards/white_card.dart';
import '../design/custom_colors.dart';
import '../design/custom_decoration.dart';
import '../modals/products/register_products.dart';
import '../shared/navbar.dart';

class ProductsView extends StatefulWidget {
  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String dropdownValue = 'Habilitados';

  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getProductsEnabled();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    String searchValue = "";
    return Container(
      color: Colors.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Productos"),
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
                      if (searchValue.isEmpty) {
                        NotificationsService.showSnackbarError("Ingrese el código del Producto para realizar la búsqueda");
                      }else{
                        await productProvider.getProductsForCode(searchValue);
                      }
                       
                    },
                    text: "Buscar",
                    color: Colors.white,
                    colorText: Colors.black
                ),
                Spacer(),
                CustomFlatButton(
                    onPressed: () async {
                       await productProvider.getProductsLowStock();
                    },
                    text: "Listar Productos Bajo stock",
                    color: Colors.white,
                    colorText: Colors.black
                ),
                SizedBox(width: 15),
                CustomFlatButton(
                    onPressed: () {
                      print("Tap Nuevo productos");
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterProductsModal(products: null),
                            );
                          });
                    },
                    text: "Nuevo",
                    color: Colors.white,
                    colorText: Colors.black),
                SizedBox(width: 44)
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: WhiteCard(
                child: PaginatedDataTable(
              columns: [

                DataColumn(label: Text('Código')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Precio (S/.)')),
                DataColumn(label: Text('Costo (S/.)')),
                DataColumn(label: Text('Stock')),
                DataColumn(label: Text('Stock Mínimo')),
                DataColumn(label: Text('Categoría')),
                DataColumn(label: Text('Descripción')),
                DataColumn(label: Text('Acciones'))
              ],
              source: ProductsDTS(products, context),
              header: Row(children: [
                Text('Productos'),
                Spacer(),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['Habilitados', 'Deshabilitados']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: CustomColor.primaryColor(), fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    if( newValue == 'Habilitados' ) {
                        // Habilitados
                        await productProvider.getProductsEnabled();
                        
                    } else {
                      // inhabilitados
                        await productProvider.getProductsDisabled();
                    }
                    setState(()  {
                  
                      dropdownValue = newValue!;
                    });

                  },
                ),
                SizedBox(
                  width: 20,
                )
              ]),
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
            )),
          )
        ],
      ),
    );
  }
}
