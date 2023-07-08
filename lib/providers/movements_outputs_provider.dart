
import 'package:almacen_web_fe/api/serviceApi.dart';
import 'package:almacen_web_fe/models/http/movement_disabled_response.dart';
import 'package:almacen_web_fe/models/http/movement_register_response.dart';
import 'package:almacen_web_fe/models/http/movements_response.dart';
import 'package:almacen_web_fe/models/movements_outputs.dart';
import 'package:flutter/material.dart';

import '../models/product_item.dart';
import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class MovementsOutputsProvider extends ChangeNotifier {

  List<MovementsOutputs> movementsOutputs = [];


  
  getMovementsOutputsEnabled() async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-salida-aprobados');
        final movementsResp = MovementsOutputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsOutputs = [...movementsResp.data!];
          print( this.movementsOutputs );
        } else{
          this.movementsOutputs = [];
        }
        print(this.movementsOutputs);

        notifyListeners();

    } catch (e) {
       this.movementsOutputs = [];
      print('Error al Listar movimientos de salida');
      NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }


  getMovementsOutputsDisabled() async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-salida-anulados');
        final movementsResp = MovementsOutputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsOutputs = [...movementsResp.data!];
          print( this.movementsOutputs );
        } else{
          this.movementsOutputs = [];
        }
        print(this.movementsOutputs);

        notifyListeners();

    } catch (e) {
       this.movementsOutputs = [];
      print('Error al Listar movimientos de salida');
      NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }

  getMovementsOutputsForCode(String code) async {

    try{
      final resp = await ServiceApi.httpGet('ux-gestion-movimientos/sam/servicio-al-cliente/v1/obtener-movimientos-salida-por-codigo/$code');
        final movementsResp = MovementsOutputsResponse.fromMap(resp);

        if (movementsResp.data != null){
          this.movementsOutputs = [...movementsResp.data!];
          print( this.movementsOutputs );
        } else{
          this.movementsOutputs = [];
        }
        print(this.movementsOutputs);

        notifyListeners();

    } catch (e) {
      print('Error al Listar movimientos de salida');
     NotificationsService.showSnackbarError('No cuentas con los privilegios');
    }

  }


Future newMovementOutput( String codigo, String factura, String fecha,
   String cliente, List<ProductItem> products ) async {

    final int id_user = LocalStorage.prefs.getInt('id') ?? 0;
    final data = {
      "codigo" : codigo,
      "factura": factura,   
      "fecha": fecha,
      "id_usuario": id_user,
      "cliente": cliente,
      "lista_items": List<dynamic>.from(products.map((x) => x.toMap())),
    };
    
    try {
      print('Request Create Movements Output:  ----> ${data.toString()}');
      final json = await ServiceApi.post('ux-gestion-movimientos/sam/servicio-al-cliente/v1/agregar-movimientos-salida', data );
      final movementsResp= MovementsOutputssRegisterResponse.fromMap(json);

      if (movementsResp.movimiento != null){
          movementsOutputs.add( movementsResp.movimiento!);
      } else{
          String message = movementsResp.message ?? 'Error al registrar el movimiento de salida';
          throw message;
      }
      notifyListeners();
      
    } catch (e) {
      throw 'Error al registrar el movimiento de salida';
    }

  }
  

   Future disabledMovementOutput( int id ) async {

    try {

      final json = await ServiceApi.put('ux-gestion-movimientos/sam/servicio-al-cliente/v1/anular-movimientos-salida/$id', {} );
      final movementsResp= MovementsOutputssDisabledResponse.fromMap(json);

      if (movementsResp.data != null){
          movementsOutputs.removeWhere((movement) => movement.id == id );
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


}