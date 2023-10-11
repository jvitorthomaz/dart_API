
import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwtSecret']!;

  //construtor para não permitir ser instanciado
  JwtHelper._();

  static JwtClaim getClaims(String token){
    return verifyJwtHS256Signature(token, _jwtSecret);
  }
}

// import 'package:dart_application/application/config/aplication_config.dart';
// import 'package:get_it/get_it.dart';
// import 'package:jaguar_jwt/jaguar_jwt.dart';

// final env = GetIt.I.get<ApplicationConfig>().env;
// class JwtHelper {
//   static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwtSecret']!;

//   //construtor para não permitir ser instanciado
//   JwtHelper._();

//   static JwtClaim getClaims(String token){
//     return verifyJwtHS256Signature(token, _jwtSecret);
//   }
// }