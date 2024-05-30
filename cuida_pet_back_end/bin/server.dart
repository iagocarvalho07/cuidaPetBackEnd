import 'dart:io';

import 'package:cuida_pet_back_end/application/config/application_config.dart';
import 'package:cuida_pet_back_end/application/middlewares/cors/cors_middlewares.dart';
import 'package:cuida_pet_back_end/application/middlewares/defultContentType/defult_content_type.dart';
import 'package:cuida_pet_back_end/application/middlewares/security/security_middleware.dart';
import 'package:get_it/get_it.dart';
// import 'package:cuida_pet_back_end/controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router();
void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  final getit = GetIt.I;

  // application Config
  final appConfig = ApplicationConfig();
  appConfig.loadConfigAplication(_router);
  final handler = Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(
          DefultContentType(contentype: "application/json;charset=utf-8")
              .handler)
      .addMiddleware(SecurityMiddleware(log: getit.get()).handler)
      .addMiddleware(logRequests())
      .addHandler(_router);
  final port = int.parse(Platform.environment['PORT'] ?? '8085');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
