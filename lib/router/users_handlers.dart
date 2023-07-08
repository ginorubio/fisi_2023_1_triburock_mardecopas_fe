import 'package:almacen_web_fe/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../providers/sidebar_provider.dart';
import '../ui/views/users_view.dart';

class UsersHandlers {
  static Handler usuarios = Handler(handlerFunc: (context, params) {
    Provider.of<SideBarProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.usuariosRoute);

    return UsersView();
  });
}
