
import 'dart:io';

import 'package:dart_application/application/middlewares/middlewares.dart';
import 'package:shelf/src/response.dart';
import 'package:shelf/src/request.dart';

class CorsMiddlewares extends Midlewares{

  final Map<String,String> headers = {
    'Access-Controll-Allow-Origin': '*',
    'Access-Controll-Allow-Method': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Controll-Allow-Header': '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}'
  };
 
  @override
  Future<Response> execute(Request request) async{
    
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: headers);
    }

    final response = await innerHandler(request);

    return response.change(headers: headers);
  }
  
}