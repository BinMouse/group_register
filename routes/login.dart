import 'package:dart_frog/dart_frog.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../models/db_client.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  // Только POST
  if (request.method != HttpMethod.post) {
    return Response(statusCode: 405, body: 'Method Not Allowed');
  }

  final body = await request.json();

  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (username == null || password == null) {
    return Response(statusCode: 400, body: 'Missing username or password');
  }

  // Используем параметризированный запрос
  final result = await DbClient.instance.pool.execute(
    'SELECT hashed_password FROM Users WHERE username = :username',
    {'username': username},
  );

  print('Query result: $result');

  print('Row count: ${result.numOfRows}');

  if (result.numOfRows == 1) {
    final storedHashedPassword = result.rows.first.typedColByName('hashed_password');
    

    final hashedInputPassword = sha256.convert(utf8.encode(password)).toString();
      if (hashedInputPassword == storedHashedPassword) {
        return Response.json(
          body: {'status': 'success', 'message': 'Login successful'},
        );
      }
  }
  return Response(statusCode: 401, body: 'Invalid username or password');
}
