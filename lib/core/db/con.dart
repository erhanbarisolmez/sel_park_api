import 'package:postgres/postgres.dart';

void main(List<String> arguments) async {
  final conn = PostgreSQLConnection("localhost", 5432, 'postgres',
      username: 'postgres', password: 'postgres');
  await conn.open();

  // CREATE USER DATA
//   await conn.query('''
//    insert into tbl_user("name",email,"password") values('barış','baris@gmail.com','testbaris123')
// ''');
  // READ USER DATA
  var results = await conn.query('https://api.ibb.gov.tr/ispark/Park');

  // for (var row in results) {
  //   print('''
  //       ====
  //       id: ${row[0]}
  //       name: ${row[1]}
  //       email: ${row[2]}
  //       password: ${row[3]}
  //       ====
  //   ''');
  // }
  print(results);

  //UPDATE USER
//   await conn.query('''
// update tbl_user set email='ahmet@gmail.com' where user_id=1
// ''');

//DELETE USER
  // await conn.query("delete from tbl_user where email='ahmet@gmail.com' ");

// SEED DB
  // final mockStr = await File('./ispark.json').readAsString();
  // final mockData = json.decode(mockStr);
  // final mockDataStream = Stream.fromIterable(mockData);

  // await for (var row in mockDataStream) {
  //   await conn.query('''
  //       insert into tbl_ispark("parkName","capacity","emptyCapacity","freeTime","district","workHours")
  //       values(@parkName,@capacity,@emptyCapacity,@freeTime,@district,@workHours)
  //   ''', substitutionValues: {
  //     'parkName': row["parkName"],
  //     'capacity': row["capacity"],
  //     'emptyCapacity': row["emptyCapacity"],
  //     'freeTime': row["freeTime"],
  //     'district': row["district"],
  //     'workHours': row["workHours"],
  //   });
  // }

  // await conn.transaction((ctx) async {
  //   await for (var row in mockDataStream) {
  //     await ctx.query('''
  //       insert into tbl_ispark("parkName","capacity","emptyCapacity","freeTime","district","workHours")
  //       values(@parkName,@capacity,@emptyCapacity,@freeTime,@district,@workHours)
  //   ''', substitutionValues: {
  //       'parkName': row["parkName"],
  //       'capacity': row["capacity"],
  //       'emptyCapacity': row["emptyCapacity"],
  //       'freeTime': row["freeTime"],
  //       'district': row["district"],
  //       'workHours': row["workHours"],
  //     });
  //   }
  // });

  //Reservation information
  // var resultsMap = await conn.mappedResultsQuery('''
  // select C."name", I."parkName", E.reservation_id, E.reservation_date,I.district, I."freeTime"
  // from tbl_reservation E inner join tbl_user C on E.user_id=C.user_id inner join
  // tbl_ispark I on I.park_id=E.park_id''');
  // print(resultsMap);

  // create reservation
  // await conn.query('''
  //   create table tbl_reservation(
  //     reservation_id serial primary key not null,
  //     user_id int not null,
  //     park_id int not null,
  //     reservation_date date,
  //     reservation_updated_date date
  //   )
  // ''');

  // insert reservation
  // await conn.transaction((ctx) async {
  //   await ctx.query('''
  //   insert into tbl_reservation(user_id, park_id, reservation_date)
  //   values(2, 1062,current_timestamp ) ''');
  // });

  await conn.close();
}
