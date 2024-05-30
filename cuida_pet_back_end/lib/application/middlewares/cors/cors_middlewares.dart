import 'dart:io';

import 'package:cuida_pet_back_end/application/middlewares/middlewares.dart';
import 'package:shelf/shelf.dart';

class CorsMiddlewares extends Middlewares {
  final Map<String, String> header = {
    'Access-Control-Allow-Origin': "*",
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Header':
        "${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}",
  };
  @override
  Future<Response> execute(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: header);
    }
    final responnse = await innerHandler(request);
    return responnse.change(headers: header);
  }
}
