import 'package:postgres/postgres.dart';
import 'package:self_park/core/db/connect.dart';

Future<bool> addParkQuery(String parkName, int capacity, int emptyCapacity,
    int freeTime, String district, String workHours) async {
// Controller, operator ekleme sorgusu
  PostgreSQLConnection? connection =
      await connectToDB(); // core/db/connect.dart

  try {
    // mail control
    var nameControl = await connection?.query('''
        select "parkName" from tbl_ispark where "parkName" = @name
    ''', substitutionValues: {'name': parkName});
    if (nameControl!.isNotEmpty) {
      return false;
    }

    var result = await connection
        ?.query('''insert into tbl_ispark("parkName","capacity","emptyCapacity","freeTime", "district", "workHours") values(@parkName,@capacity,@emptyCapacity,@freeTime,@district,@workHours)''',
            substitutionValues: {
          "parkName": parkName,
          "capacity": capacity,
          "emptyCapacity": emptyCapacity,
          "freeTime": freeTime,
          "district": district,
          "workHours": workHours
        });
    await connection!.close();

    if (result!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on PostgreSQLException catch (e) {
    if (e.code == '23505') {
      return false;
    }
    rethrow;
  } finally {
    await connection!.close();
  }
}

Future<bool> checkIfParkExists(String parkName) async {
  PostgreSQLConnection? connect = await connectToDB();

  try {
    var result = await connect?.query(''' 
        select count(*) from tbl_ispark where "parkName" = @name
    ''', substitutionValues: {'name': parkName});

    int rowCount = result!.first[0] as int;
    bool parkExists = rowCount > 0;

    await connect!.close();

    return parkExists;
  } finally {
    await connect!.close();
  }
}
