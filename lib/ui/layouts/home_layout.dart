//import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:almacen_web_fe/providers/sidebar_provider.dart';
import 'package:almacen_web_fe/ui/shared/navbar.dart';
import 'package:flutter/material.dart';

import '../shared/sidebar.dart';

//import 'package:admin_dashboard/ui/shared/navbar.dart';
//import 'package:admin_dashboard/ui/shared/sidebar.dart';

class HomeLayout extends StatefulWidget {

  final Widget child;

  const HomeLayout({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with SingleTickerProviderStateMixin {


  @override
  void initState() { 
    super.initState();
    
    SideBarProvider.menuController = new AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 300) 
    );

  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color( 0xffEDF1F2 ),
      body: Stack(
        children: [
          Row(
            children: [
              
                Sidebar(),

              Expanded(
                child: Column(
                  children: [
                    // Navbar

                    // View 
                    Expanded(
                      child: Container(
                        //padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
                        child: widget.child,
                      )
                    ),
                  ],
                ),
              )
              // Contenedor de nuestro view
            ],
          ),
        ],
      )
    );
  }
}