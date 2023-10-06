
import 'package:dart_application/application/config/database_connection_configuration.dart';
import 'package:dart_application/application/logger/i_logger.dart';
import 'package:dart_application/application/logger/logger.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:get_it/get_it.dart';

class ApplicationConfig {

  Future<void> loadConfigApplication() async {
    await _loadEnv();
    _loadDatabaseConfig();
    _configLogger();
  }

  Future<void> _loadEnv() async => load();

  void _loadDatabaseConfig(){
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!, 
      user: env['DATABASE_USER'] ?? env['databaseUser']!, 
      port: int.tryParse(env['DATABASE_PORT'] ?? env['databaseHost']!) ?? 0, 
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!, 
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  void _configLogger() => GetIt.I.registerLazySingleton<ILogger>(() => Logger());

}

