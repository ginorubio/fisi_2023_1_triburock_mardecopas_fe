import 'package:almacen_web_fe/ui/views/home_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../ui/views/login_view.dart';

class AdminHandlers {

  static Handler login = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);

      if ( authProvider.authStatus == AuthStatus.notAuthenticated )
        return LoginView();
      else 
        return HomeView();

    }
  );


}