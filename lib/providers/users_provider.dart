import 'package:flutter/cupertino.dart';

import '../api/serviceApi.dart';
import '../models/http/user_response.dart';
import '../models/users.dart';
import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class UsersProvider extends ChangeNotifier {
  List<Users> users = [];

  getUsersEnabled() async {
    try {
      final resp = await ServiceApi.httpGet('/users/');
      final usersResp = UsersResponse.fromMap(resp);

      if (usersResp.data != null) {
        this.users = [...usersResp.data!];
        print(this.users);
      } else {
        this.users = [];
      }
      print(this.users);

      notifyListeners();
    } catch (e) {
      this.users = [];
      print('Error al Listar usuarios');
       NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }
  }

  getUsersDisabled() async {
    try {
      final resp = await ServiceApi.httpGet('/users/inhabilitados');
      final usersResp = UsersResponse.fromMap(resp);

      if (usersResp.data != null) {
        this.users = [...usersResp.data!];
        print(this.users);
      } else {
        this.users = [];
      }
      print(this.users);

      notifyListeners();
    } catch (e) {
      this.users = [];
      print('Error al Listar usuarios');
      NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }
  }

  Future newUser(int rol_id, String nombre_usuario, String correo,
      String direccion, String telefono, String password, String dni) async {

    final data = {
      "username": nombre_usuario,
      "email": correo,
      "password": password,
      "direccion": direccion,
      "telefono": telefono,
      "dni": dni,
      "rol_id": rol_id
    };

    try {
      print('Request Create User:  ----> ${data.toString()}');
      final json = await ServiceApi.post('/users/create', data);
      final usersResp = UsersResponse.fromMap(json);

      if (usersResp.data != null) {
        users.add(usersResp.data![0]);
      } else {
        String message = usersResp.message ?? 'Error al registrar el Usuario';
        throw message;
      }
      notifyListeners();
    } catch (e) {
      throw 'Error al registrar el Usuario';
    }
  }

  Future enabledUser(int id) async {
    try {
      final json = await ServiceApi.put('/users/habilitar/$id', {});
      final usersResp = UsersResponse.fromMap(json);

      if (usersResp.data != null) {
        users.removeWhere((user) => user.id == id);
      } else {
        String message = usersResp.message ?? 'Error al habilitar el usuario';
        throw message;
      }

      notifyListeners();
    } catch (e) {
      print(e);
      throw ('Error al habilitar el usuario');
    }
  }

  Future disabledUser(int id) async {
    try {
      final json = await ServiceApi.put('/users/inhabilitar/$id', {});
      final usersResp = UsersResponse.fromMap(json);

      if (usersResp.data != null) {
        users.removeWhere((user) => user.id == id);
      } else {
        String message = usersResp.message ?? 'Error al inhabilitar el usuario';
        throw message;
      }

      notifyListeners();
    } catch (e) {
      print(e);
      throw ('Error al inhabilitar el usuario');
    }
  }

  Future updateUser(int id, String email, String password,String telefono,String direccion, int rol
      ) async {
    final data = {
      "email": email,
      "password": password,
      "telefono": telefono,
      "direccion": direccion,
      "rol": telefono,

    };

    try {
      print('Request Update User:  ----> ${data.toString()}');

      final json = await ServiceApi.put('/users/update/$id', data);
      final usersResp = UsersResponse.fromMap(json);

      if (usersResp.data != null) {
        Users user = users.firstWhere((element) => element.id == id);
        int index = users.indexOf(user);
        users[index] = usersResp.data![0];
      } else {
        String message = usersResp.message ?? 'Error al actualizar el usuario';
        throw message;
      }
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar el usuario';
    }
  }
}
