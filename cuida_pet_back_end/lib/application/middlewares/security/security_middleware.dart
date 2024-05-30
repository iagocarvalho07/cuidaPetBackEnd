import 'dart:convert';

import 'package:cuida_pet_back_end/application/helpers/jwt_helper.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

import 'package:cuida_pet_back_end/application/logger/i_logger.dart';
import 'package:cuida_pet_back_end/application/middlewares/Middlewares.dart';
import 'package:cuida_pet_back_end/application/middlewares/security/security_skip_url.dart';

class SecurityMiddleware extends Middlewares {
  final ILogger log;
  final skypUrl = <SecuritySkipUrl>[];
  SecurityMiddleware({
    required this.log,
  });

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skypUrl.contains(SecuritySkipUrl(
          url: "/${request.url.path}", method: request.method))) {
        return innerHandler(request);
      }
      final authHeader = request.headers['Authorization'];
      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }
      final authHeaderContent = authHeader.split(' ');
      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authorizationtoken = authHeaderContent[1];
      final calims = JwtHelper.getClaim(authorizationtoken);

      if (request.url.path != 'auth/refresh') {
        calims.validate();
      }
      final claimsMap = calims.toJson();
      final userId = claimsMap['sub'];
      final supplierId = claimsMap['supplier'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }
      final securityHeaders = {
        'user': userId,
        'access_token': authorizationtoken,
        'supplier': supplierId,
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch (e, s) {
      log.error("erro ao validaar token JWT", e, s);
      return Response.forbidden(jsonEncode({}));
    } catch (e, s) {
      log.error("internal server errro ao validaar token JWT", e, s);
      return Response.forbidden(jsonEncode({}));
    }
  }
}
