import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtHelper {
  JwtHelper._();
  static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwt_secret_dev']!;
  static JwtClaim getClaim(String token) {
    return verifyJwtHS256Signature(token, _jwtSecret);
  }
}
