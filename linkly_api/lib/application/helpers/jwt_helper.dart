
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