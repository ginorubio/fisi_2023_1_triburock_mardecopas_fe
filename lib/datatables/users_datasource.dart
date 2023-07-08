import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../providers/users_provider.dart';
import '../services/notifications_service.dart';
import '../ui/design/custom_colors.dart';
import '../ui/modals/users/edit_users.dart';

class UsersDTS extends DataTableSource {
  final List<Users> users;
  final BuildContext context;

  UsersDTS(this.users, this.context);

  @override
  DataRow getRow(int index) {
    final users = this.users[index];
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(users.id.toString())),
      DataCell(Text(users.username ?? "")),
      DataCell(Text(users.dni ?? "")),
      DataCell(Text(users.email ?? "")),
      DataCell(Text(users.direccion ?? "")),
      DataCell(Text(users.telefono ?? "")),
      DataCell(Text(users.rol.toString())),
      DataCell(Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.green,
                size: 25,
              ),
              onPressed: () {
                print("Presionando Edit");
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: EditUsersModal(users: users),
                      );
                    });
              }),
          (users.estado == 'habilitado')
              ? IconButton(
                  icon: Icon(Icons.arrow_downward_rounded,
                      color: Colors.red.withOpacity(0.8)),
                  onPressed: () {
                    final dialogInhabilitar = AlertDialog(
                      title: Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.green,
                        size: 40,
                      ),
                      // alignment: Alignment.center,
                      content: Text(
                          '¿Desea inhabilitar al usuario ${users.username}?'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Inhabilitar'),
                          onPressed: () async {
                            try {
                              await userProvider.disabledUser(users.id ?? 0);
                              NotificationsService.showSnackbar(
                                  '${users.username} Inhabilitado!');
                              Navigator.of(context).pop();
                            } catch (e) {
                              Navigator.of(context).pop();
                              NotificationsService.showSnackbarError(
                                  'No se pudo inhabilitar el producto');
                            }
                          },
                        ),
                      ],
                    );

                    showDialog(
                        context: context, builder: (_) => dialogInhabilitar);
                  })
              : IconButton(
                  icon: Icon(Icons.arrow_upward_rounded,
                      color: Colors.blue.withOpacity(0.8)),
                  onPressed: () {
                    final dialogHabilitar = AlertDialog(
                      title: Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.blue,
                        size: 40,
                      ),
                      // alignment: Alignment.center,
                      content: Text(
                          '¿Desea Habilitar el producto ${users.username}?'),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Habilitar'),
                          onPressed: () async {
                            //PEgar al servicio eliminar
                            try {
                              await userProvider.enabledUser(users.id ?? 0);
                              NotificationsService.showSnackbar(
                                  '${users.username} habilitado!');
                              Navigator.of(context).pop();
                            } catch (e) {
                              Navigator.of(context).pop();
                              NotificationsService.showSnackbarError(
                                  'No se pudo habilitar el usuario');
                            }
                          },
                        ),
                      ],
                    );

                    showDialog(
                        context: context, builder: (_) => dialogHabilitar);
                  })
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
