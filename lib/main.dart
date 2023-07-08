import 'package:almacen_web_fe/providers/auth_provider.dart';

import 'package:almacen_web_fe/providers/category_provider.dart';
import 'package:almacen_web_fe/providers/filepdf_movement_provider.dart';

import 'package:almacen_web_fe/providers/movements_inputs_provider.dart';
import 'package:almacen_web_fe/providers/movements_outputs_provider.dart';
import 'package:almacen_web_fe/providers/products_provider.dart';
import 'package:almacen_web_fe/providers/sidebar_provider.dart';
import 'package:almacen_web_fe/providers/users_provider.dart';
import 'package:almacen_web_fe/router/router.dart';
import 'package:almacen_web_fe/services/navigation_services.dart';
import 'package:almacen_web_fe/services/notifications_service.dart';
import 'package:almacen_web_fe/ui/layouts/auth/auth_layout.dart';
import 'package:almacen_web_fe/ui/layouts/home_layout.dart';
import 'package:almacen_web_fe/ui/layouts/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/serviceApi.dart';
import 'providers/product_item_provider.dart';
import 'services/local_storage.dart';

void main() async {
  await LocalStorage.configurePrefs();
  ServiceApi.configureDio();

  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideBarProvider()),
        ChangeNotifierProvider(create: (_) => MovementsOutputsProvider()),
        ChangeNotifierProvider(create: (_) => MovementsInputsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => ProductsItemProvider()),
        ChangeNotifierProvider(create: (_) => FilePdfMovementProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Almacenera Mercantil web',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking)
          return SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return HomeLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
