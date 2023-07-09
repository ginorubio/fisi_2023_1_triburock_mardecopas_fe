import 'package:almacen_web_fe/ui/shared/widgets/logo.dart';
import 'package:almacen_web_fe/ui/shared/widgets/menu_item_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/sidebar_provider.dart';
import '../../router/router.dart';
import '../../services/navigation_services.dart';

class Sidebar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideBarProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideBarProvider>(context);

    return Container(
      width: 240,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50),
          MenuItemCustom(
            text: 'Inicio',
            icon: Icons.home,
            onPressed: () => navigateTo(Flurorouter.inicioRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.inicioRoute,
          ),
          MenuItemCustom(
            text: 'Producto',
            icon: Icons.production_quantity_limits_sharp,
            onPressed: () => navigateTo(Flurorouter.productosRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.productosRoute,
          ),
          MenuItemCustom(
            text: 'Categoría',
            icon: Icons.category,
            onPressed: () => navigateTo(Flurorouter.categoriaRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.categoriaRoute,
          ),
          MenuItemCustom(
            text: 'Movimientos Salida',
            icon: Icons.keyboard_double_arrow_right,
            onPressed: () => navigateTo(Flurorouter.movimientosRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.movimientosRoute,
          ),
          MenuItemCustom(
            text: 'Movimientos Entrada',
            icon: Icons.keyboard_double_arrow_left_sharp,
            onPressed: () => navigateTo(Flurorouter.movimientosInputsRoute),
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.movimientosInputsRoute,
          ),
          MenuItemCustom(
            text: 'Gestión de usuarios',
            icon: Icons.person,
            onPressed: () => navigateTo(Flurorouter.usuariosRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.usuariosRoute,
          ),
          MenuItemCustom(
              text: 'Información del sistema',
              icon: Icons.info,
              onPressed: () {}),
          MenuItemCustom(
              text: 'Logout',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
