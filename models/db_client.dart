import 'package:dotenv/dotenv.dart';
import 'package:mysql_client/mysql_client.dart';


/// Клиент базы данных
class DbClient {
  DbClient._internal();

  static final DbClient _instance = DbClient._internal();

  static DbClient get instance => _instance;

  late final MySQLConnectionPool pool;

  final env = DotEnv(includePlatformEnvironment: true)..load();
  
  /// Инициализация соединения
  Future<void> init() async {
    try {
      pool = MySQLConnectionPool(
        host: env['DB_HOST'] ?? 'localhost', // Значение по умолчанию
        port: int.tryParse(env['DB_PORT'] ?? '3306') ?? 3306,
        userName: env['DB_USER'] ?? 'root',
        password: env['DB_PASSWORD'] ?? '',
        maxConnections: 10,
        databaseName: env['DB_NAME'] ?? 'class_register_db',
        timeoutMs: int.tryParse(env['DB_TIMEOUT'] ?? '1600') ?? 1600,
      );
    } catch (e) {
      print(e);
    }
  }
}
