import 'package:almacen_web_fe/router/router.dart';
import 'package:almacen_web_fe/ui/views/category_view.dart';
import 'package:almacen_web_fe/ui/views/home_view.dart';
import 'package:almacen_web_fe/ui/views/movements_inputs_view.dart';
import 'package:almacen_web_fe/ui/views/movements_outputs_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/sidebar_provider.dart';
import '../ui/views/login_view.dart';
import '../ui/views/users_view.dart';
import '../ui/views/products_view.dart';

class HomeHandlers {

  static Handler home = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.inicioRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return HomeView();
      else 
        return LoginView();
    }
  );


   static Handler movements_inputs = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.movimientosInputsRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return MovemenentsInputsView();
      else 
        return LoginView();
    }
  );


  static Handler movements_outputs = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.movimientosRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return MovemenentsOutputsView();
      else 
        return LoginView();
    }
  );


  static Handler categoria = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideBarProvider>( context, listen: false)
        .setCurrentPageUrl( Flurorouter.categoriaRoute );
       
        if ( authProvider.authStatus == AuthStatus.authenticated )
        return CategoryView();
      else 
        return LoginView();

    }
  );

  static Handler productos = Handler(
    handlerFunc: (context, params) {

    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.productosRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return ProductsView();
      else 
        return LoginView();
    }
  );
  
    static Handler usuarios = Handler(handlerFunc: 
    (context, params) {

    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuariosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return UsersView();
    else
      return LoginView();
  });

}
