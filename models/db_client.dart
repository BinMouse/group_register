import 'package:mysql_client/mysql_client.dart';

/// Клиент базы данных
class DbClient {
  DbClient._internal();

  static final DbClient _instance = DbClient._internal();

  static DbClient get instance => _instance;

  late final MySQLConnectionPool pool;

  /// Инициализация соединения
  Future<void> init() async {
    try {
      pool = await MySQLConnectionPool(
        host: 'localhost',
        port: 3306,
        userName: 'cr_user',
        password: '162534',
        maxConnections: 10,
        databaseName: 'class_register_db',
        timeoutMs: 1600,
      );
    } catch (e) {
      print(e);
    }
  }
}
