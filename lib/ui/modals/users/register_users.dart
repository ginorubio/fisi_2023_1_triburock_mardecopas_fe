import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/inputs/custom_form_textfield.dart';
import 'package:almacen_web_fe/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/rol.dart';
import '../../../models/users.dart';
import '../../../providers/users_provider.dart';
import '../../../services/notifications_service.dart';
import '../../design/custom_colors.dart';

class RegisterUsersModal extends StatefulWidget {
  final Users? users;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  RegisterUsersModal({
    Key? key,
    this.users,
  }) : super(key: key);

  @override
  _RegisterUsersModalState createState() => _RegisterUsersModalState();
}

class _RegisterUsersModalState extends State<RegisterUsersModal> {
  String codigo = '';
  String rol = '';
  String nombreUsuario = '';
  String correo = '';
  String contrasena = '';
  String direcion = '';
  String telefono = '';
  String dni = '';
  String estado = '';
  String dropdownValueRol = "admin";
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
              "Registrar Usuarios",
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
                        (value) => nombreUsuario = value,
                        "Nombre",
                        "Digite el nombre"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => dni = value, "DNI", "Digite el DNI"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm((value) => correo = value,
                        "Correo", "Digite el correo"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => direcion = value,
                        "Dirección",
                        "Ingrese su direccion"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => telefono = value,
                        "Telefono",
                        "Digite su telefono"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => contrasena = value,
                        "Contraseña",
                        "Digite la contraseña"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomInputs.customTextFieldForm(
                        (value) => contrasena = value,
                        "Repetir Contraseña",
                        "Repetir la contraseña"),
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

                      if ( nombreUsuario.isEmpty || correo.isEmpty || contrasena.isEmpty || dni.isEmpty){
                        NotificationsService.showSnackbarError("Faltan ingresar datos o los ingresados son incorrectos");
                        }else{
                          try {
                          Rol rol = rols.firstWhere((element) => element.name == dropdownValueRol);
                          

                          await userProvider.newUser(rol.id_rol ?? 120, nombreUsuario, correo, direcion, telefono, contrasena, dni);
                          NotificationsService.showSnackbar(
                              '${widget.users?.username ?? ""} Actualizado!');
                          Navigator.of(context).pop();
                        } catch (e) {
                          Navigator.of(context).pop();
                          NotificationsService.showSnackbarError(
                              'No se pudo actualizar el usuario');
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
