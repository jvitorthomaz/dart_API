
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
      expiry: DateTime.now().add(Duration(days: 21)),  
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

    static String refreshToken(String accessToken) {
    // final env = GetIt.I.get<ApplicationConfig>().env;
    // final expiry = int.parse(env['REFRESH_TOKEN_EXPIRE_DAYS'] ?? env['refresh_token_expire_days']!);
    // final notBefore = int.parse(env['REFRESH_TOKEN_NOT_BEFORE_HOURS'] ?? env['refresh_token_not_before_hours']!);

    final claimSet = JwtClaim(
      issuer: accessToken,
      subject: 'RefreshToken',
      expiry: DateTime.now().add(Duration(days: 21)),
      notBefore: DateTime.now().add(Duration(hours: 1)),
      //notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
    );

    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }
}
