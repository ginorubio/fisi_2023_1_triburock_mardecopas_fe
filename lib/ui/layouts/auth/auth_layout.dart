import 'package:almacen_web_fe/ui/layouts/auth/widgets/background_img.dart';
import 'package:almacen_web_fe/ui/layouts/auth/widgets/custom_title.dart';
import 'package:almacen_web_fe/ui/layouts/auth/widgets/linksBar.dart';
import 'package:flutter/material.dart';

import '../../design/custom_colors.dart';

class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({
    Key? key, 
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        // isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [

            ( size.width > 1000 )
              ? _DesktopBody( child: child)
              : _MobileBody( child: child ),
            LinksBar()
          ],
        ),
      )
    );
  }
}


class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      color: CustomColor.primaryColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),

          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundAlmacen(),
          )
        ],
      ),
    );
  }
}


class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({
    Key? key, 
    required this.child
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: CustomColor.primaryColor(),
      child: Row(
        children: [

          // Twitter Background
          Expanded(child: BackgroundAlmacen()),
          

          // View Container
          Container(
            width: 600,
            height: double.infinity,
            color:CustomColor.primaryColor(),
            child: Column(
              children: [
                SizedBox( height: 20 ),
                CustomTitle(),
                SizedBox( height: 50 ),
                Expanded(child: child ),
              ],
            ),
          )

        ],
      ),
    );
  }
}