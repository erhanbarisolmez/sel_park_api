import 'package:self_park/core/db/connect.dart';
import 'package:self_park/core/db/query/controller/addPark/models/park.dart';

late Future<List<Park>> parkListFuture;

Future<List<Park>> parkList() async {
  final connect = await connectToDB();
  final results = await connect?.query('''
     select * from tbl_ispark order by park_id desc LIMIT 10
  ''');

  final parkListResult = results?.map((row) {
    final parkId = BigInt.from(row[0] as int);
    final parkName = row[1] as String;
    final capacity = row[2].toString();
    final emptyCapacity = row[3].toString();
    final freeTime = row[4].toString();
    final district = row[5] as String;
    final workHours = row[6] as String;

    return Park(
        parkId: parkId,
        parkName: parkName,
        capacity: capacity,
        emptyCapacity: emptyCapacity,
        freeTime: freeTime,
        district: district,
        workHours: workHours);
  }).toList();

  await connect!.close();

  return parkListResult!;
}

Future<void> deletePark(BigInt parkId) async {
  final connect = await connectToDB();
  await connect!.execute('''
  delete from tbl_ispark where park_id = @parkId
''', substitutionValues: {'parkId': parkId.toString()});
  await connect.close();
}
