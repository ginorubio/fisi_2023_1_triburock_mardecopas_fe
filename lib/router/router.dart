import 'package:almacen_web_fe/router/admin_handlers.dart';
import 'package:almacen_web_fe/router/home_handlers.dart';

import 'package:almacen_web_fe/router/no_page_found_handlers.dart';

import 'package:almacen_web_fe/router/users_handlers.dart';

import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRoute = '/';

  // Home Inicial
  static String inicioRoute = '/inicio';
  static String loginRoute = '/auth/login';
  static String movimientosRoute = '/movimientos';
  static String movimientosInputsRoute = '/movimientos-ingresos';
  static String categoriaRoute = '/categoria';
  static String productosRoute = '/productos';
  static String usuariosRoute = '/usuarios';
  static void configureRoutes() {
    //Root route
    router.define( rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
   
   //Login
   router.define( loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
   
   // Home
    router.define( inicioRoute, handler:  HomeHandlers.home, transitionType: TransitionType.fadeIn );

   //Movimientos
   router.define( movimientosRoute , handler: HomeHandlers.movements_outputs , transitionType: TransitionType.fadeIn );

   
   //Movimientos Ingresos

   router.define( movimientosInputsRoute , handler: HomeHandlers.movements_inputs, transitionType: TransitionType.fadeIn );

   //Categoria
   router.define( categoriaRoute , handler: HomeHandlers.categoria , transitionType: TransitionType.fadeIn );
   
   //Productos
    router.define(productosRoute, handler: HomeHandlers.productos,  transitionType: TransitionType.fadeIn);


    //Usuarios
    router.define(usuariosRoute,
        handler: HomeHandlers.usuarios, transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
