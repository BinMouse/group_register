import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'models/db_client.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  // Инициализация базы данных
  DbClient.instance.init();
  return serve(handler, ip, port);
}
