import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection?> connectToDB() async {
  try {
    PostgreSQLConnection connection = PostgreSQLConnection("10.0.2.2", 5432,
        'postgres', //linux desktop 159.146.105.182 / avd  10.0.2.2
        username: 'postgres',
        password: 'postgres');
    await connection.open();

    return connection;
  } catch (e) {
    return null;
  }
  // PostgreSQL veritabanına bağlanmak için kullanılacak fonksiyon
}
