import 'package:cuida_pet_back_end/application/config/database_conect_config.dart';
import 'package:cuida_pet_back_end/application/database/i_database_conection.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';


@LazySingleton(as: IDatabaseConection)
class DatabaseConectionImpl implements IDatabaseConection {
  final DatabaseConectConfig _conectConfig;
  DatabaseConectionImpl(this._conectConfig);

  @override
  Future<MySqlConnection> onpenConnection() {
    return MySqlConnection.connect(ConnectionSettings(
      host: _conectConfig.host,
      port: _conectConfig.port,
      user: _conectConfig.user,
      password: _conectConfig.password,
      db: _conectConfig.databaseName
    ));
  }
}
