import 'package:postgres/postgres.dart';

import '../../../connect.dart';

Future<bool> authenticateUser(String email, String password) async {
  PostgreSQLConnection? connection =
      await connectToDB(); // core/db/connect.dart
  var result = await connection?.query(
      '''select * from tbl_user where email=@email and password=@password''',
      substitutionValues: {'email': email, 'password': password});
  await connection?.close();
  if (result != null && result.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
