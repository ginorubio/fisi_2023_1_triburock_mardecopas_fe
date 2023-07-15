
import 'package:almacen_web_fe/models/http/movement_disabled_response.dart';
import 'package:almacen_web_fe/models/http/movement_item_response.dart';
import 'package:almacen_web_fe/models/http/movement_register_response.dart';
import 'package:almacen_web_fe/models/http/movements_response.dart';
import 'package:almacen_web_fe/models/movement_item.dart';
import 'package:almacen_web_fe/models/movements_inputs.dart';
import 'package:flutter/material.dart';

import '../api/serviceApi.dart';
import '../models/product_item.dart';
import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class MovementsInputsProvider extends ChangeNotifier {

  List<MovementsInputs> movementsInputs = [];
  List<MovementItem> itemsMovementsInputs = [];

  getMovementsInputsEnabled() async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-entradas-aprobados');
        final movementsResp = MovementsInputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsInputs = [...movementsResp.data!];
          print( this.movementsInputs );
        } else{
          this.movementsInputs = [];
        }
        print(this.movementsInputs);

        notifyListeners();

    } catch (e) {
      this.movementsInputs = [];
      print('Error al Listar movimientos de entrada');
       NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }


  getMovementsInputsDisabled() async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-entradas-anulados');
        final movementsResp = MovementsInputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsInputs = [...movementsResp.data!];
          print( this.movementsInputs );
        } else{
          this.movementsInputs = [];
        }
        print(this.movementsInputs);

        notifyListeners();

    } catch (e) {
      this.movementsInputs = [];
      print('Error al Listar movimientos de entrada');
       NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }

  getMovementsInputsForCode(String code) async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-entradas/$code');
        final movementsResp = MovementsInputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsInputs = [...movementsResp.data!];
          print( this.movementsInputs );
        } else{
          this.movementsInputs = [];
        }
        print(this.movementsInputs);

        notifyListeners();

    } catch (e) {
      print('Error al Listar movimientos de entrada');
      NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }


Future newMovementInput( String codigo, String orden_compra, String fecha,
   String proveedor, List<ProductItem> products ) async {

    final int id_user = LocalStorage.prefs.getInt('id') ?? 0;
    final data = {
      "codigo" : codigo,
      "orden_compra": orden_compra,   
      "fecha": fecha,
      "id_usuario": id_user,
      "proveedor": proveedor,
      "lista_items": List<dynamic>.from(products.map((x) => x.toMap())),
    };
    
    try {
      print('Request Create Movements Inputs:  ----> ${data.toString()}');
      final json = await ServiceApi.post('ux-gestion-movimientos/sam/servicio-al-cliente/v1/agregar-movimientos-entradas', data );
      final movementsResp= MovementsInputsRegisterResponse.fromMap(json);

      if (movementsResp.movimiento != null){
          movementsInputs.add( movementsResp.movimiento!);
      } else{
          String message = movementsResp.message ?? 'Error al registrar el movimiento de entrada';
          throw message;
      }
      notifyListeners();
      
    } catch (e) {
      throw 'Error al registrar el movimiento de entrada';
    }

  }
  

 Future disabledMovementInput( int id ) async {

    try {

      final json = await ServiceApi.put('ux-gestion-movimientos/sam/servicio-al-cliente/v1/anular-movimientos-entradas/$id', {} );
      final movementsResp= MovementsInputsDisabledResponse.fromMap(json);

      if (movementsResp.data != null){
          movementsInputs.removeWhere((movement) => movement.id == id );
      } else{
          String message = movementsResp.message ?? 'Error al inhabilitar categel producto';
          throw message;
      }
      
     
      notifyListeners();
      
    } catch (e) {
      print(e);
      throw('Error al inhabilitar el producto');
    }

  }

   getItemsMovementsInputsForID(int id) async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-items-entradas/$id');
        final itemsMovementsResp = MovementItemResponse.fromMap(resp);

        if (itemsMovementsResp.data != null){
          this.itemsMovementsInputs = [...itemsMovementsResp.data!];
        } else{
          this.itemsMovementsInputs = [];
          
        }
        print(this.itemsMovementsInputs);
        notifyListeners();

    } catch (e) {
      print(e.toString());
      this.movementsInputs = [];
      NotificationsService.showSnackbarError('Error al Listar los items de movimientos de entrada');
    }

  }

  clearItemsMovementsInputs(){
    this.itemsMovementsInputs = [];
  }

}