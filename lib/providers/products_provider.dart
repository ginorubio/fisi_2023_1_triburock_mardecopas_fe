import 'package:almacen_web_fe/models/http/products_response.dart';
import 'package:almacen_web_fe/models/products.dart';
import 'package:flutter/material.dart';

import '../api/serviceApi.dart';
import '../services/local_storage.dart';
import '../services/notifications_service.dart';

class ProductsProvider extends ChangeNotifier {
  List<Products> products = [];
   getProductsEnabled() async {
    
    try{
      final resp = await ServiceApi.httpGet('/productos/');
      final productsResp = ProductsResponse.fromMap(resp);

      if (productsResp.data != null){
        this.products = [...productsResp.data!];
        print( this.products );
      } else{
        this.products = [];
      }
      print(this.products);

      notifyListeners();
    } catch (e) {
      print('Error al Listar productos');
       NotificationsService.showSnackbarError('No se pudo listar los productos');
    }
  }

  getProductsDisabled() async {
    
    try{
      final resp = await ServiceApi.httpGet('/productos/inhabilitados');
        final productsResp = ProductsResponse.fromMap(resp);

        if (productsResp.data != null){
          this.products = [...productsResp.data!];
          print( this.products );
        } else{
          this.products = [];
        }
        print(this.products);

        notifyListeners();

    } catch (e) {
      print('Error al Listar productos');
       NotificationsService.showSnackbarError('No se pudo listar los productos');
    }
  }

    getProductsLowStock() async {
    
    try{
      final resp = await ServiceApi.httpGet('/productos/stockminimo');
        final productsResp = ProductsResponse.fromMap(resp);

        if (productsResp.data != null){
          this.products = [...productsResp.data!];
          print( this.products );
        } else{
          this.products = [];
        }
        print(this.products);

        notifyListeners();

    } catch (e) {
      print('Error al Listar productos con stock mínimo');
       NotificationsService.showSnackbarError('No se pudo listar los productos con stock mínimo');
    }
  }

getProductsForCode(String codigo) async {
    
    try{
      final resp = await ServiceApi.httpGet('/productos/read/$codigo');
        final productsResp = ProductsResponse.fromMap(resp);

        if (productsResp.data != null){
          this.products = [...productsResp.data!];
          print( this.products );
        } else{
          this.products = [];
        }
        print(this.products);

        notifyListeners();

    } catch (e) {
      print('Error al buscar el producto');
       NotificationsService.showSnackbarError('No se encontro el producto de código: $codigo');
    }
  }
  Future newProduct( String nombre, int id_categoria, String codigo,
   String unidad_medida, double costo, String descripcion, 
   double precio, int stock, int stock_min ) async {

  final int id_user = LocalStorage.prefs.getInt('id') ?? 0;
    final data = {
      "nombre" : nombre,
      "id_categoria": id_categoria,   
      "id_usuario": id_user,
      "codigo": codigo,
      "unidad_medida": unidad_medida,
      "costo": costo,
      "descripcion": descripcion,
      "precio": precio,
      "stock": stock,
      "stock_min": stock_min
    };
    
    try {
      print('Request Create Product:  ----> ${data.toString()}');
      final json = await ServiceApi.post('/productos/', data );
      final productsResp= ProductsResponse.fromMap(json);

      if (productsResp.data != null){
          products.add( productsResp.data![0]);
      } else{
          String message = productsResp.message ?? 'Error al registrar el Producto';
          throw message;
      }
      notifyListeners();
      
    } catch (e) {
      throw 'Error al registrar el Producto';
    }

  }


  Future enabledProduct( int id ) async {

    try {

      final json =await ServiceApi.put('/productos/habilitar/$id', {} );
      final productsResp= ProductsResponse.fromMap(json);

      if (productsResp.data != null){
          products.removeWhere((product) => product.id == id );
      } else{
          String message = productsResp.message ?? 'Error al habilitar el producto';
          throw message;
      }
      
     
      notifyListeners();
      
      
    } catch (e) {
      print(e);
      throw('Error al habilitar el producto');
    }

  }

    Future disabledProduct( int id ) async {

    try {

      final json = await ServiceApi.put('/productos/inhabilitar/$id', {} );
      final productsResp= ProductsResponse.fromMap(json);

      if (productsResp.data != null){
          products.removeWhere((product) => product.id == id );
      } else{
          String message = productsResp.message ?? 'Error al inhabilitar categel producto';
          throw message;
      }
      
     
      notifyListeners();
      
    } catch (e) {
      print(e);
      throw('Error al inhabilitar el producto');
    }

  }

  Future updateProduct( int id, String descripcion, double precio, double stock_min) async {

    final data = {
      "descripcion" : descripcion,
      "precio": precio,   
      "stock_min": stock_min
    };
    
    try {
      print('Request Update Product:  ----> ${data.toString()}');

      final json = await ServiceApi.put('/productos/$id', data );
      final productsResp= ProductsResponse.fromMap(json);

      if (productsResp.data != null){
          Products product = products.firstWhere((element) => element.id == id);
          int index = products.indexOf(product);
          products[index] = productsResp.data![0];
      } else{
          String message = productsResp.message ?? 'Error al actualizar el Producto';
          throw message;
      }
      notifyListeners();
      
    } catch (e) {
      throw 'Error al actualizar el Producto';
    }

  }

   Future getProductItemForCode(String codigo) async  {
    
    try{
      final resp = await ServiceApi.httpGet('/productos/read/$codigo');
        final productsResp = ProductsResponse.fromMap(resp);

        if (productsResp.data != null && (productsResp.data?.length ?? 0) > 0 ){
          final productsTemp = [...productsResp.data!];
          return productsTemp[0];
        } else{
          print('Error al buscar el producto');
          NotificationsService.showSnackbarError('No se encontro el producto de código: $codigo');
          return  Products();
        }

    } catch (e) {
       throw('Error al buscar el producto');
       
    }
  }

}
