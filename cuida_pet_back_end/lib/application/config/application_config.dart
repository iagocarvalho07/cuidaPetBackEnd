import 'package:cuida_pet_back_end/application/config/database_conect_config.dart';
import 'package:cuida_pet_back_end/application/config/service_locator_config.dart';
import 'package:cuida_pet_back_end/application/logger/i_logger.dart';
import 'package:cuida_pet_back_end/application/logger/i_logger_impl.dart';
import 'package:cuida_pet_back_end/application/routers/router_configure.dart';
import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class ApplicationConfig {
  void loadConfigAplication(Router router) async {
    await _loadEnv();
    _loadDataBaseConfig();
    _configLogger();
    _loadDependences();
    _loadRouterConfigure(router);
  }

  Future<void> _loadEnv() async => load();
  void _loadDataBaseConfig() {
    final databaseConfig = DatabaseConectConfig(
      host: env["DATABASE_HOST"] ?? env['databaseHost']!,
      user: env["DATABASE_USER"] ?? env['databaseUser']!,
      port: int.tryParse(env["DATABASE_HOST"] ?? env['databasePort']!) ?? 0,
      password: env["DATABASE_PASSWORD"] ?? env['databasePassword']!,
      databaseName: env["DATABASE_NAME"] ?? env['databaseName']!,
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() =>
      GetIt.I.registerLazySingleton<ILogger>(() => ILoggerImpl());

  void _loadDependences() => configureDependencies();

  void _loadRouterConfigure(Router router) => RouterConfigure(router).configure();
}
