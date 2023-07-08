
import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../api/serviceApi.dart';
import '../services/notifications_service.dart';

class FilePdfMovementProvider extends ChangeNotifier {

   Future<Uint8List> getReporteMovimientoPorID(String id) async {
    
    try{

      final response = await ServiceApi.httpGetPDF('/movimiento/reporte/$id');
      return response;

    } catch (e) {
      
      print('Error al obtener el reporte');
      NotificationsService.showSnackbarError('Error al generar reporte');
      return Uint8List(0);
    }
  }

}