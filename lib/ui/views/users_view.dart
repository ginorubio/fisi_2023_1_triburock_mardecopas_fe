import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../datatables/users_datasource.dart';
import '../../providers/users_provider.dart';
import '../buttons/custom_flatButton.dart';
import '../cards/white_card.dart';
import '../design/custom_colors.dart';
import '../design/custom_decoration.dart';
import '../modals/users/register_users.dart';
import '../shared/navbar.dart';
import '../shared/widgets/search_text.dart';

class UsersView extends StatefulWidget {
  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String dropdownValue = 'Habilitados';
  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getUsersEnabled();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context).users;
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    return Container(
      color: Colors.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Usuarios"),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            decoration: CustomBoxDecoration.navBoxDecoration(),
            child: Row(
              children: [
                SizedBox(width: 40),
                SearchText(),
                SizedBox(width: 15),
                CustomFlatButton(
                    onPressed: () => {},
                    text: "Buscar",
                    color: Colors.white,
                    colorText: Colors.black),
                Spacer(),
                CustomFlatButton(
                    onPressed: () {
                      print("Tap Nuevo usuarios");
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: RegisterUsersModal(users: null),
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
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Dirección')),
                DataColumn(label: Text('Telefono')),
                DataColumn(label: Text('Rol')),
                DataColumn(label: Text('Acciones'))
              ],
              source: UsersDTS(users, context),
              header: Row(children: [
                Text('Usuarios'),
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
                    if (newValue == 'Habilitados') {
                      // Habilitados
                      await userProvider.getUsersEnabled();
                    } else {
                      // inhabilitados
                      await userProvider.getUsersDisabled();
                    }
                    setState(() {
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
