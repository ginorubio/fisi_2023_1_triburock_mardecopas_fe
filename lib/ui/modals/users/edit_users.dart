import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/rol.dart';
import '../../../models/users.dart';
import '../../../providers/users_provider.dart';
import '../../../services/notifications_service.dart';
import '../../buttons/custom_flatButton.dart';
import '../../design/custom_colors.dart';
import '../../inputs/custom_form_textfield.dart';
import '../../labels/custom_labels.dart';

class EditUsersModal extends StatefulWidget {
  final Users? users;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  EditUsersModal({
    Key? key,
    this.users,
  }) : super(key: key);

  @override
  _EditUsersModalState createState() => _EditUsersModalState();
}

class _EditUsersModalState extends State<EditUsersModal> {
  String email = '';
  String password = '';
  String telefono = '';
  String direccion = '';
  String dropdownValueRol = 'admin';
List<Rol> rols = [
    Rol(id_rol: 100, name: "admin"),
    Rol(id_rol: 120, name: "jefe_almacen"),
    Rol(id_rol: 121, name: "almacenero"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(0),
      height: 1200,
      width: 410, //
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Container(
            color: Color(0xff493F60),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Text(
              "Editar Usuario",
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
                    CustomInputs.customTextFieldFormDisabled(
                        "Nombre", widget.users?.username ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldFormDisabled(
                        "DNI", widget.users?.dni ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                     CustomInputs.customTextFieldFormDisabled(
                        "Correo", widget.users?.email ?? ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => direccion = value, "Dirección", ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => telefono = value, "Telefono", ""),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => password = value, "Contraseña", "", isPassword: true),
                    SizedBox(
                      height: 20,
                    ),
                    
                    Row(
                      children: [
                        Text("Roles ",
                          style: TextStyle(color: CustomColor.primaryColor())
                        ),
                        Spacer(),
                        DropdownButton<String>(
                          disabledHint: Text("Seleccionar el rol"),
                          value: dropdownValueRol,
                          items: rols 
                          .map(( value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(
                                value.name ?? "",
                                style: TextStyle(
                                  color: CustomColor.primaryColor(),
                                  fontSize: 16),
                              ),
                            );
                          }).toList(),

                          onChanged: (newValue)  {
                              setState(()  {
                                  dropdownValueRol = newValue ?? "";
                                });
                            
                          
                          },
                        ),
                      ]
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
                      try {
                         Rol rol = rols.firstWhere((element) => element.name == dropdownValueRol);
                        

                        await userProvider.updateUser(
                            widget.users?.id ?? 0,
                            email,
                            password,
                            telefono,
                            direccion,
                            rol.id_rol ?? 120);
                        NotificationsService.showSnackbar(
                            '${widget.users?.username ?? ""} Actualizado!');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo actualizar el usuario');
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
