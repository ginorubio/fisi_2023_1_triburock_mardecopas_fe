
import 'package:almacen_web_fe/providers/sidebar_provider.dart';
import 'package:almacen_web_fe/ui/views/no_page_found_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';


class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {

      Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl('/404');

      return NoPageFoundView();
    }
  );


}

