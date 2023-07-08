
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../api/serviceApi.dart';
import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class FilePdfMovementProvider extends ChangeNotifier {

  Uint8List pdfFileMovement = Uint8List(0);

   getReporteMovimientoPorID(String id) async {
    
    try{
      final resp = await ServiceApi.httpGet('/movimiento/reporte/$id');
       

    } catch (e) {
      print('Error al obtener el reporte');
       NotificationsService.showSnackbarError('');
    }
  }

}