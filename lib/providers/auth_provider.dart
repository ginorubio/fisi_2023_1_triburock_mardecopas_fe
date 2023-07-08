import 'package:almacen_web_fe/api/serviceApi.dart';
import 'package:flutter/material.dart';

import '../models/http/auth_response.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigation_services.dart';
import '../services/notifications_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier {

  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    this.isAuthenticated();
  }


  login( String email, String password ) {

    final data = {
      'email': email,
      'password': password
    };
    ServiceApi.post('/auth/signIn', data ).then(
      (json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json);

        if (authResponse.token != null) {
          authStatus = AuthStatus.authenticated;
          LocalStorage.prefs.setString('token', authResponse.token! );
          LocalStorage.prefs.setInt('id', authResponse.id! );
          LocalStorage.prefs.setInt('rol_id', authResponse.rol_id! );
          LocalStorage.prefs.setString('fullname', authResponse.fullname! );
          NavigationService.replaceTo(Flurorouter.inicioRoute);

          ServiceApi.configureDio();
          notifyListeners();
        }else{
          String message = authResponse.message ?? 'Error en el login';
          NotificationsService.showSnackbarError(message);
        }
        

      }
      
    ).catchError( (e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Error en el login');
    });
  }

  Future<bool> isAuthenticated() async {

    final token = LocalStorage.prefs.getString('token');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }else{

      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }
    

  }


  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}
