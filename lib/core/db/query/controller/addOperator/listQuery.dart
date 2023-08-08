import 'package:self_park/core/db/connect.dart';

Future<bool> listQuery() async {
  // Operator, son eklenen 3 sorgusu
  final connect = await connectToDB(); // core/db/connect.dart
  final results = await connect?.query('''
       select  * from tbl_user ORDER BY user_id desc LIMIT 3
  ''');
  final userList =
      results?.map((row) => User.fromMap(row as Map<String, dynamic>)).toList();
  print(userList);
  await connect?.close();

  for (final user in userList!) {
    print('''
        ${user.userId},
        ${user.name},
        ${user.mail},
        ${user.password}
    ''');
  }
  if (results!.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

class User {
  final int userId;
  final String name;
  final String mail;
  final String password;

  User(
      {required this.userId,
      required this.name,
      required this.mail,
      required this.password});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] as int,
      name: map['name'] as String,
      mail: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
