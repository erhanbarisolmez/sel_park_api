import 'package:flutter/material.dart';
import 'package:self_park/core/db/query/controller/addPark/models/edit.dart';

import '../../../../../../core/db/connect.dart';
import '../../../../../../language/language_items.dart';

class UpdateParkView extends StatefulWidget {
  const UpdateParkView({Key? key}) : super(key: key);

  @override
  State<UpdateParkView> createState() => _UpdateParkViewState();
}

class _UpdateParkViewState extends State<UpdateParkView> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait
            ? const UpdateColumn()
            : const UpdateRow(),
      ),
    );
  }
}

class UpdateColumn extends StatefulWidget {
  const UpdateColumn({Key? key}) : super(key: key);

  @override
  State<UpdateColumn> createState() => _UpdateColumnState();
}

class _UpdateColumnState extends State<UpdateColumn> {
  late ParkEdit park;
  late TextEditingController parkNameController;
  late TextEditingController capacityController;
  late TextEditingController emptyCapacityController;
  late TextEditingController freeTimeController;
  late TextEditingController districtController;
  late TextEditingController workHoursController;

  void onParkNameChanged(String value) {
    setState(() {
      park.parkName = value;
    });
  }

  void onDistrictChanged(String value) {
    setState(() {
      park.district = value;
    });
  }

  void onCapacityChanged(String value) {
    setState(() {
      park.capacity = int.parse(value);
    });
  }

  void onEmptyCapacityChanged(String value) {
    setState(() {
      park.emptyCapacity = int.parse(value);
    });
  }

  void onFreeTimeChanged(String value) {
    setState(() {
      park.freeTime = int.parse(value);
    });
  }

  void onWorkHoursChanged(String value) {
    setState(() {
      park.workHours = value;
    });
  }

  Future<void> searchPark(String retrievedParkName) async {
    final connect = await connectToDB();
    final queryResult = await connect?.query(
        'SELECT "parkName", capacity,  "emptyCapacity", "freeTime", district, "workHours" from tbl_ispark where "parkName" = @parkName',
        substitutionValues: {'parkName': retrievedParkName});

    if (queryResult != null && queryResult.isNotEmpty) {
      final row = queryResult.first;

      final retrievedParkName = row[0] as String;
      final retrievedCapacity = row[1] as int;
      final retrievedEmptyCapacity = row[2] as int;
      final retrievedFreeTime = row[3] as int;
      final retrievedDistrict = row[4] as String;
      final retrievedWorkHours = row[5] as String;

      setState(() {
        park = ParkEdit(
          parkName: retrievedParkName,
          capacity: retrievedCapacity,
          emptyCapacity: retrievedEmptyCapacity,
          freeTime: retrievedFreeTime,
          district: retrievedDistrict,
          workHours: retrievedWorkHours,
        );
        parkNameController.text = retrievedParkName;
        capacityController.text = retrievedCapacity.toString();
        emptyCapacityController.text = retrievedEmptyCapacity.toString();
        freeTimeController.text = retrievedFreeTime.toString();
        districtController.text = retrievedDistrict;
        workHoursController.text = retrievedWorkHours;
      });
    } else {
      setState(() {
        park = ParkEdit(
            parkName: '',
            capacity: 0,
            emptyCapacity: 0,
            freeTime: 0,
            district: '',
            workHours: '');
        parkNameController.text = '';
        capacityController.text = '';
        emptyCapacityController.text = '';
        freeTimeController.text = '';
        districtController.text = '';
        workHoursController.text = '';
      });
    }
    await connect?.close();
  }

  Future<bool> updatePark() async {
    final connect = await connectToDB();
    await connect?.execute(
      '''
   update tbl_ispark set STcapacity = @capacity, "emptyCapacity"= @emptyCapacity, "freeTime"=@freeTime, district= @district, "workHours"=@workHours where "parkName"=@parkName
        ''',
      substitutionValues: {
        'parkName': park.parkName,
        'capacity': park.capacity,
        'emptyCapacity': park.emptyCapacity,
        'freeTime': park.freeTime,
        'district': park.district,
        'workHours': park.workHours,
      },
    );

    setState(
      () {
        park = ParkEdit(
            parkName: '',
            capacity: 0,
            emptyCapacity: 0,
            freeTime: 0,
            district: '',
            workHours: '');
        parkNameController.text = '';
        capacityController.text = '';
        emptyCapacityController.text = '';
        freeTimeController.text = '';
        districtController.text = '';
        workHoursController.text = '';
      },
    );
    await connect?.close();
    return true;
  }

  Future<void> deletePark(String parkName) async {
    final connect = await connectToDB();
    await connect!.execute('''
          delete from tbl_ispark where "parkName" = @parkName
    ''', substitutionValues: {
      'parkName': parkName,
    });
    await connect.close();
    parkNameController.text = '';
    capacityController.text = '';
    emptyCapacityController.text = '';
    freeTimeController.text = '';
    districtController.text = '';
    workHoursController.text = '';
  }

  @override
  void dispose() {
    parkNameController.dispose();
    capacityController.dispose();
    emptyCapacityController.dispose();
    freeTimeController.dispose();
    districtController.dispose();
    workHoursController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    park = ParkEdit(
        parkName: '',
        capacity: 0,
        emptyCapacity: 0,
        freeTime: 0,
        district: '',
        workHours: '');

    parkNameController = TextEditingController();
    capacityController = TextEditingController();
    emptyCapacityController = TextEditingController();
    freeTimeController = TextEditingController();
    districtController = TextEditingController();
    workHoursController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const SizedBox(
                  child: Text(
                    'Edit Park',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: parkNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.parkNameTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.local_parking_rounded),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 270,
                      child: TextField(
                        controller: districtController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.districtTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.add_location_alt_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        controller: freeTimeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.freeTimeTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.more_time_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        controller: workHoursController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.workHoursTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.work_history_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 297,
                      child: TextField(
                        controller: capacityController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.capacity,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.check_box_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 6)),
                    SizedBox(
                      width: 297,
                      child: TextField(
                        controller: emptyCapacityController,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.emptyCapacity,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.check_box_outline_blank_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: _buttonStyle().copyWith(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(180, 50))),
                              onPressed: () async {
                                await searchPark(parkNameController.text);
                              },
                              child: const Text('Search')),
                          ElevatedButton(
                              style: _buttonStyle().copyWith(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(300, 50))),
                              onPressed: () async {
                                String parkNameText = parkNameController.text;
                                String capacityText = capacityController.text;
                                String emptyCapacityText =
                                    emptyCapacityController.text;
                                String freeTimeText = freeTimeController.text;
                                String districtText = districtController.text;
                                String workHoursText = workHoursController.text;

                                if (parkNameText.isNotEmpty &&
                                    capacityText.isNotEmpty &&
                                    emptyCapacityText.isNotEmpty &&
                                    freeTimeText.isNotEmpty &&
                                    districtText.isNotEmpty &&
                                    workHoursText.isNotEmpty) {
                                  park = ParkEdit(
                                      parkName: parkNameText,
                                      capacity: int.parse(capacityText),
                                      emptyCapacity:
                                          int.parse(emptyCapacityText),
                                      freeTime: int.parse(freeTimeText),
                                      district: districtText,
                                      workHours: workHoursText);
                                  bool edit = await updatePark();
                                  if (edit) {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Success'),
                                          content:
                                              const Text('Update success.'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'))
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text('Update error.'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'))
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Please fill in all fields.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: const Text('Update')),
                          ElevatedButton(
                            style: _buttonStyle(),
                            onPressed: () {
                              deletePark(park.parkName);
                            },
                            child: const Text('Delete'),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateRow extends StatefulWidget {
  const UpdateRow({Key? key}) : super(key: key);

  @override
  State<UpdateRow> createState() => _UpdateRowState();
}

class _UpdateRowState extends State<UpdateRow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const SizedBox(
                  child: Text(
                    'Edit Park',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                const SizedBox(
                  width: 600,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.parkNameTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.local_parking_rounded),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 270,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.districtTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.add_location_alt_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.freeTimeTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.more_time_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 160,
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.workHoursTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.work_history_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 297,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.capacity,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.check_box_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 6)),
                    SizedBox(
                      width: 297,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.emptyCapacity,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.check_box_outline_blank_sharp),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: _buttonStyle(),
                              onPressed: () {},
                              child: const Text('Search')),
                          ElevatedButton(
                              style: _buttonStyle().copyWith(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(400, 50))),
                              onPressed: () {},
                              child: const Text('Update')),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ButtonStyle _buttonStyle() {
  return const ButtonStyle(
      fixedSize: MaterialStatePropertyAll(Size(100, 50)),
      backgroundColor: MaterialStatePropertyAll(Colors.black12));
}
