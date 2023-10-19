// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:dart_application/application/helpers/jwt_helper.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/application/middlewares/middlewares.dart';
import 'package:dart_application/application/middlewares/security/security_skip_url.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

class SecurityMiddleware extends Midlewares {

  final ILogger log;
  final skypUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/', method: 'GET'),
    //SecuritySkipUrl(url: '/favicon.ico', method: 'GET'),
    SecuritySkipUrl(url: '/auth/register', method: 'POST'),
    SecuritySkipUrl(url: '/auth/', method: 'POST'),
    SecuritySkipUrl(url: '/suppliers/user', method: 'GET'),
    SecuritySkipUrl(url: '/suppliers/user', method: 'POST'),

  ];

  SecurityMiddleware({
    required this.log,
  });


  @override
  Future<Response> execute(Request request) async{
    try {
      print('/${request.url.path}');
 
      if(skypUrl.contains(SecuritySkipUrl(url: '/${request.url.path}', method: request.method))) {
        
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
        // return Response.forbidden(jsonEncode({}));
      }

      final authHeaderContent = authHeader.split(' ');

      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
        // return Response.forbidden(jsonEncode({}));
      }

      final authorizationToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authorizationToken);

      if (request.url.path != 'auth/refresh') {
        claims.validate();
      }

      final claimsMap = claims.toJson();

      final userId = claimsMap['sub'];
      final supplierId = claimsMap['supplier'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
        'supplier': supplierId != null ? '$supplierId' : null
      };

      return innerHandler(request.change(headers: securityHeaders));
      

    } on JwtException catch (e, s) {
      log.error('Erro ao validar o token JWT', e, s);
      return Response.forbidden(jsonEncode({}));

    } catch (e, s) {
      log.error('Internal Server Error', e, s);
      return Response.forbidden(jsonEncode({}));
    }

  }
  
}
