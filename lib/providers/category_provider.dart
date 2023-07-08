

import 'package:almacen_web_fe/api/serviceApi.dart';
import 'package:almacen_web_fe/models/category.dart';
import 'package:almacen_web_fe/models/http/category_response.dart';
import 'package:flutter/material.dart';

import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class CategoryProvider extends ChangeNotifier {

  List<Category> categories = [];

  getCategoryEnabled() async {
    try {
      final resp = await ServiceApi.httpGet('ux-gestion-categorias/sam/servicio-al-cliente/v1/obtener-categorias-habilitadas');
      print(resp);

      final categoriesResp = CategoryConsultResponse.fromMap(resp);

      if (categoriesResp.data != null){
        this.categories = [...categoriesResp.data!];
        print( this.categories );
      } else{
        this.categories = [];
      }

      print( this.categories );

      notifyListeners();

    } catch (e) {
       print('Error al Listar categoria');
       NotificationsService.showSnackbarError('No se pudo listar categorias');
    }
  }

    getCategoryDiseabled() async {
    
    try{
      final resp = await ServiceApi.httpGet('ux-gestion-categorias/sam/servicio-al-cliente/v1/obtener-categorias-deshabilitadas');
      final categoriesResp = CategoryConsultResponse.fromMap(resp);

      if (categoriesResp.data != null){
        this.categories = [...categoriesResp.data!];
        print( this.categories );
      } else{
        this.categories = [];
      }

      print( this.categories );

      notifyListeners();

    } catch (e) {
      print('Error al Listar categoria');
       NotificationsService.showSnackbarError('No se pudo listar categorias');
    }
  }

  Future newCategory( String codigo, String nombre ) async {

  final int id_user = LocalStorage.prefs.getInt('id') ?? 0;
    final data = {
      'codigo': codigo,
      'nombre': nombre,
      'id_usuario': id_user
    };
    
    try {
      print('Request Create category:  ----> ${data.toString()}');
      final json = await ServiceApi.post('ux-gestion-categorias/sam/servicio-al-cliente/v1/agregar-categorias', data );
      final categoriesResp= CategoryConsultResponse.fromMap(json);

      if (categoriesResp.data != null){
          categories.add( categoriesResp.data![0]);
      } else{
          String message = categoriesResp.message ?? 'Error al crear categoria';
          throw message;
      }
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear categoria';
    }

  }


  Future enabledCategory( int id ) async {

    try {

      final json =await ServiceApi.put('ux-gestion-categorias/sam/servicio-al-cliente/v1/dar-alta-categorias/$id', {} );
      final categoriesResp= CategoryConsultResponse.fromMap(json);

      if (categoriesResp.data != null){
          categories.removeWhere((categoria) => categoria.id == id );
      } else{
          String message = categoriesResp.message ?? 'Error al habilitar categoria';
          throw message;
      }

      notifyListeners();
      
      
    } catch (e) {
      print(e);
      throw('Error al habilitar categoria');
    }

  }

    Future disabledCategory( int id ) async {

    try {

      final json = await ServiceApi.put('ux-gestion-categorias/sam/servicio-al-cliente/v1/dar-baja-categorias/$id', {} );
      final categoriesResp= CategoryConsultResponse.fromMap(json);

      if (categoriesResp.data != null){
          categories.removeWhere((categoria) => categoria.id == id );
      } else{
          String message = categoriesResp.message ?? 'Error al inhabilitar categoria';
          throw message;
      }
      
     
      notifyListeners();
      
    } catch (e) {
      print(e);
      throw('Error al inhabilitar categoria');
    }

  }

  geCategoryForCode(String codigo) async {
    
    try{
      final resp = await ServiceApi.httpGet('ux-gestion-categorias/sam/servicio-al-cliente/v1/obtener-categorias-por-codigo/$codigo');
        final categoryResp = CategoryConsultResponse.fromMap(resp);

        if (categoryResp.data != null){
          this.categories = [...categoryResp.data!];
          print( this.categories );
        } else{
          this.categories = [];
          print(this.categories);
        }
        

        notifyListeners();

    } catch (e) {
      print('Error al buscar la categoria');
       NotificationsService.showSnackbarError('No se encontro la categoría de código: $codigo');
    }
  }
}