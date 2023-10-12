
import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwtSecret']!;

  //construtor para não permitir ser instanciado
  JwtHelper._();

  static String generateJWT(int userId, int? supplierId) {

    //final expire = int.parse(env['JWT_EXPIRE'] ?? env['jwtExpire']!);

    final claimSet = JwtClaim(
      issuer: 'linkly',
      subject: userId.toString(),
      expiry: DateTime.now().add(Duration(days: 1)),  
      //expiry: DateTime.now().add(Duration(days: expire)),
      notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{'supplier': supplierId},
      maxAge: const Duration(days: 1)
    );

    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }


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