

import 'package:almacen_web_fe/models/product_item.dart';
import 'package:flutter/material.dart';

import '../services/notifications_service.dart';
class ProductsItemProvider extends ChangeNotifier {
  List<ProductItem> productsItemImputs = [];

  List<ProductItem> productsItemOutputs = [];


   getItemsProductsMovementsInputs() {
    
      try{

        print(this.productsItemImputs);

        notifyListeners();
      } catch (e) {
        print('Error al Listar productos items');
        NotificationsService.showSnackbarError('Error al Listar productos items');
      }
  }

     getItemsProductsMovementsOutputs() {
    
      try{

        print(this.productsItemOutputs);

        notifyListeners();
      } catch (e) {
        print('Error al Listar productos items');
        NotificationsService.showSnackbarError('Error al Listar productos items');
      }
  }

  addItemMovementInput(ProductItem productItem) {
    
    try{

      this.productsItemImputs.add(productItem);
      print(this.productsItemImputs);

      notifyListeners();
    } catch (e) {
      print('Error al agregar producto a la lista');
      NotificationsService.showSnackbarError('No se pudo agregar el producto a la lista');
    }
  }

  addItemMovementOutput(ProductItem productItem) {
    
    try{

      this.productsItemOutputs.add(productItem);
      print(this.productsItemOutputs);

      notifyListeners();
    } catch (e) {
     print('Error al agregar producto a la lista');
      NotificationsService.showSnackbarError('No se pudo agregar el producto a la lista');
    }
  }

  clearProductItemInputs(){
    this.productsItemImputs = [];
  }

   clearProductItemOutputs(){
    this.productsItemOutputs = [];
  }

}