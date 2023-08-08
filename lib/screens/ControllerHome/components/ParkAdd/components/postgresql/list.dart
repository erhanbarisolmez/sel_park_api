import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_park/core/db/query/controller/addPark/getPark.dart';
import 'package:self_park/screens/ControllerHome/components/ParkAdd/components/postgresql/update.dart';

import '../../../../../../core/db/query/controller/addPark/models/park.dart';

class ListParkView extends StatefulWidget {
  const ListParkView({Key? key}) : super(key: key);

  @override
  _ListParkViewState createState() => _ListParkViewState();
}

class _ListParkViewState extends State<ListParkView> {
  late Future<List<Park>> parkListFuture;

  @override
  void initState() {
    super.initState();
    parkListFuture = parkList();
  }

  // Stream ile anlık bildirim
  Stream<List<Park>> ParkListStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield await parkList();
    }
  }

  // setState ile anlık bildirim
  // Future<List<Park>> parkList() async {
  //   final connect = await connectToDB();
  //   final results = await connect?.query('''
  //     select * from tbl_ispark order by park_id desc LIMIT 10
  //   ''');

  //   final parkListResult = results?.map((row) {
  //     final parkId = BigInt.from(row[0] as int);
  //     final parkName = row[1] as String;
  //     final capacity = row[2].toString();
  //     final emptyCapacity = row[3].toString();
  //     final freeTime = row[4].toString();
  //     final district = row[5] as String;
  //     final workHours = row[6] as String;

  //     r!eturn Park(
  //       parkId: parkId,
  //       parkName: parkName,
  //       capacity: capacity,
  //       emptyCapacity: emptyCapacity,
  //       freeTime: freeTime,
  //       district: district,
  //       workHours: workHours,
  //     );
  //   }).toList();

  //   await connect!.close();

  //   return parkListResult!;
  // }

  // Future<void> deletePark(BigInt parkId) async {
  //   final connect = await connectToDB();
  //   await connect!.execute('''
  //     delete from tbl_ispark where park_id = @parkId
  //   ''', substitutionValues: {'parkId': parkId.toString()});
  //   await connect.close();
  //   setState(() {
  //     parkListFuture = parkList();
  //   });
  // }

  void openParkDetail(Park park) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Stack(
            children: <Widget>[
              Text(park.parkName,
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black45!,
                  )),
              Text(
                park.parkName,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[300],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: [
                      Icon(Icons.drive_file_rename_outline_sharp,
                          size: 50, color: Colors.yellow.shade100),
                      const SizedBox(width: 30.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _cardText(park),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black38,
                            minimumSize: const Size(200, 50)),
                        onPressed: () {
                          const Icon(Icons.edit);
                          //navigateToList();
                        },
                        child: Text('Edit',
                            style: GoogleFonts.rajdhani(
                                color: const Color(0xffffffff),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          minimumSize: const Size(200, 50)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.rajdhani(
                            color: Colors.orange.shade100,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<Widget> _cardText(Park park) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Text(
                'District= ${park.district}',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black!),
              ),
              Text(
                'District= ${park.district}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[300],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Stack(
            children: <Widget>[
              Text('Capacity= ${park.capacity}',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black!,
                  )),
              Text(
                'Capacity= ${park.capacity}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[300],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Text('Empty Capacity= ${park.emptyCapacity}',
                  style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black!)),
              Text(
                'Empty Capacity= ${park.emptyCapacity}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[300],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Stack(
            children: <Widget>[
              Text(
                'Free Time= ${park.freeTime}',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black!),
              ),
              Text(
                'Free Time= ${park.freeTime}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[300],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Stack(
            children: <Widget>[
              Text(
                'Work Hours= ${park.workHours}',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black!),
              ),
              Text(
                'Work Hours= ${park.workHours}',
                style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.grey[300],
                ),
              )
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last 10 Park'),
      ),
      body: StreamBuilder<List<Park>>(
        //FutureBuilder<List<Park>>
        stream: ParkListStream(), //future
        builder: (BuildContext context, AsyncSnapshot<List<Park>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No parks found'));
          } else {
            final parks = snapshot.data!;
            return ListView.builder(
              itemCount: parks.length,
              itemBuilder: (context, index) {
                final park = parks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(park.parkName),
                    leading: Icon(Icons.local_parking,
                        size: 50, color: Colors.yellow.shade100),
                    subtitle: Text('Capacity: ${park.capacity}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.orange.shade100,
                        size: 28,
                      ),
                      onPressed: () => deletePark(park.parkId),
                    ),
                    onTap: () => openParkDetail(park),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const UpdateParkView();
        },
      ),
    );
  }
}
