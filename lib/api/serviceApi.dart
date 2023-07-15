

import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../services/local_storage.dart';

class ServiceApi {

  static Dio _dio = new Dio();
  
  static void configureDio() {

    // Base del url
    _dio.options.baseUrl = 'https://apimlogistnet.azure-api.net/';

//'http://localhost:4000/api'
    // ''
    // Configurar Headers
    _dio.options.headers = {
      'x-access-token': LocalStorage.prefs.getString('token') ?? '',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE', // If needed
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type', // If needed
      'Access-Control-Allow-Credentials': true // If  needed
    };

  }

  static Future httpGet( String path ) async {
    try {
      final resp = await _dio.get(path);
      print(resp.data);
      return resp.data;


    } catch (e) {
      print(e);
      throw('Error en el GET');
    }
  }

  static Future<Uint8List> httpGetPDF( String path ) async {
    try {
      
      final resp = await _dio.get(path, options: Options(responseType: ResponseType.bytes));
      print(resp.data);
      return resp.data;


    } catch (e) {
      print(e);
      throw('Error en el GET PDF');
    }
  }


  static Future post( String path, Map<String, dynamic> data ) async {

      try {
        
        final resp = await _dio.post(path, data: data);
        return resp.data;

      } catch (e) {
        print(e);
        throw('Error en el POST ${e}');
      }
    }


    static Future put( String path, Map<String, dynamic> data ) async {

      try {
        
        final resp = await _dio.put(path, data: data );
        return resp.data;

      } catch (e) {
        print(e);
        throw('Error en el PUT');
      }
    }


    static Future delete( String path, Map<String, dynamic> data ) async {

      try {
        
        final resp = await _dio.delete(path, data: data );
        return resp.data;

      } catch (e) {
        print(e);
        throw('Error en el delete');
      }
    }


}