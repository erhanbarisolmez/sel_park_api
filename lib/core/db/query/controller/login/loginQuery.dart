import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:self_park/core/db/connect.dart';

Future<bool> authenticateAdmin(String email, String password) async {
  try {
    PostgreSQLConnection? connection =
        await connectToDB(); // core/db/connect.dart
    if (connection == null) {
      print('Bağlantı hatası: Kullanıcı adı veya şifre yanlış!');
      return false;
    }
    var result = await connection
        ?.query('''select * from tbl_admin where email=@email and password=@password''',
            substitutionValues: {
          'email': email,
          'password': password
        }).timeout(const Duration(seconds: 60));
    await connection?.close();
    if (result != null && result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    File('error_log.txt').writeAsStringSync('Hata: $e');
    return false;
  }
}
