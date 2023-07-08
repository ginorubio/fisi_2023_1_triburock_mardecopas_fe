


import 'package:dio/dio.dart';

import '../services/local_storage.dart';

class ServiceApi {

  static Dio _dio = new Dio();
  
  static void configureDio() {

    // Base del url
    _dio.options.baseUrl = 'http://localhost:4000/api';
//'http://localhost:4000/api'
//20.237.49.172:4000/
// 'https://36125cea-a715-48ea-a36d-d9de0888627c.mock.pstmn.io/api'
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