// ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:self_park/core/db/connect.dart';

// import 'models/edit.dart';

// Future<void> searchPark(String retrievedParkName) async {
//   late ParkEdit park;
//   final connect = await connectToDB();
//   final queryResult = await connect?.query(
//       'SELECT "parkName", capacity,  "emptyCapacity", "freeTime", district, "workHours" from tbl_ispark where "parkName" = @parkName',
//       substitutionValues: {'parkName': retrievedParkName});

//   if (queryResult != null && queryResult.isNotEmpty) {
//     final row = queryResult.first;

//     final retrievedParkName = row[0] as String;
//     final retrievedParkCapacity = row[1].toString();
//     final retrievedEmptyCapacity = row[2].toString();
//     final retrievedFreeTime = row[3].toString();
//     final retrievedDistrict = row[4] as String;
//     final retrievedWorkHours = row[5] as String;

//     park = ParkEdit(
//         parkName: retrievedParkName,
//         capacity: retrievedParkCapacity,
//         emptyCapacity: retrievedEmptyCapacity,
//         freeTime: retrievedFreeTime,
//         district: retrievedDistrict,
//         workHours: retrievedWorkHours);
//   } else {
//     park = ParkEdit(
//         parkName: '',
//         capacity: '',
//         emptyCapacity: '',
//         freeTime: '',
//         district: '',
//         workHours: '');
//     controller().parkNameController.text = '';
//     controller().capacityController.text = '';
//     controller().emptyCapacityController.text = '';
//     controller().workHoursController.text = '';
//     controller().freeTimeController.text = '';
//     controller().districtController.text = '';
//   }
//   await connect?.close();
//   return searchPark(retrievedParkName);
// }

// class controller {
//   late final parkNameController = TextEditingController();
//   late final capacityController = TextEditingController();
//   late final emptyCapacityController = TextEditingController();
//   late final freeTimeController = TextEditingController();
//   late final districtController = TextEditingController();
//   late final workHoursController = TextEditingController();
// }
