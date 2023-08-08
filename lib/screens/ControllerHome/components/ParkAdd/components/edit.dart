import 'package:flutter/material.dart';
import 'package:self_park/core/models/Park/ParkInfoGetModel.dart';

import '../../../../../../../../language/language_items.dart';
import '../../../../../core/services/post_parkInfo_service.dart';
import '../../../../../core/widgets/confirmedDeleteShowDialog.dart';
import '../../../../../core/widgets/openParkDetailShowDialog.dart';

class EditParkView extends StatefulWidget {
  final ParkInfoGetAllModel park;
  final Function? onFetchPostItems;
  final Function? onDeletePark;
  const EditParkView(
      {Key? key,
      required this.park,
      required this.onFetchPostItems,
      required this.onDeletePark})
      : super(key: key);

  @override
  State<EditParkView> createState() => _EditParkViewState();
}

class _EditParkViewState extends State<EditParkView> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait
            ? UpdateColumn(
                park: widget.park,
                onFetchPostItems: widget.onFetchPostItems!,
                onDeletePark: widget.onDeletePark!,
              )
            : UpdateRow(
                park: widget.park,
                onFetchPostItems: widget.onFetchPostItems!,
                onDeletePark: widget.onDeletePark!,
              ),
      ),
    );
  }
}

class UpdateColumn extends StatefulWidget {
  final ParkInfoGetAllModel park;
  final Function onFetchPostItems;
  final Function? onDeletePark;

  const UpdateColumn(
      {Key? key,
      required this.park,
      required this.onFetchPostItems,
      required this.onDeletePark})
      : super(key: key);

  @override
  State<UpdateColumn> createState() => _UpdateColumnState();
}

class _UpdateColumnState extends State<UpdateColumn> {
  late final ParkInfoGetAllModel park;
  late final IParkPostService _parkPostService;

  late final Function? onFetchPostItems;
  late final Function onDeletePark;

  final TextEditingController _parkNameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _freeTimeController = TextEditingController();
  final TextEditingController _workHoursController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _emptyCapacityController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    park = widget.park;
    onFetchPostItems = widget.onFetchPostItems;
    onDeletePark = widget.onDeletePark!;
    _parkNameController.text = widget.park.parkName!;
    _districtController.text = widget.park.district!;
    _freeTimeController.text = widget.park.freeTime!.toString();
    _workHoursController.text = widget.park.workHours!.toString();
    _capacityController.text = widget.park.capacity!.toString();
    _emptyCapacityController.text = widget.park.emptyCapacity!.toString();
    _parkPostService = ParkPostService();
  }

  Future<void> updateParkInfo(ParkInfoGetAllModel updatedModel) async {
    await _parkPostService.putItemToService(updatedModel, context);
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
                    controller: _parkNameController,
                    cursorColor: Colors.amber,
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
                        controller: _districtController,
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
                        controller: _freeTimeController,
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
                        controller: _workHoursController,
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
                        controller: _capacityController,
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
                        controller: _emptyCapacityController,
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
                                      Size(490, 50))),
                              onPressed: () async {
                                bool? confirmed =
                                    await _openParkDetailShowDialog(
                                        context, park);
                                if (confirmed == true) {
                                  ParkInfoGetAllModel updatedModel =
                                      _updatedModel();

                                  await updateParkInfo(updatedModel);
                                  await widget.onFetchPostItems();
                                  Navigator.pop(context, true);
                                } else {
                                  print('cancel');
                                }
                              },
                              child: const Text('Update')),
                          ElevatedButton(
                            style: _buttonStyle(),
                            onPressed: () async {
                              bool? confirmed =
                                  await _confirmedDeleteShowDialog(
                                      context, park);
                              if (confirmed == true) {
                                await widget.onDeletePark!(park.id);
                                await widget.onFetchPostItems();
                                Navigator.pop(context, true);
                              } else {
                                print('cancel');
                              }
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

  ParkInfoGetAllModel _updatedModel() {
    ParkInfoGetAllModel updatedModel = ParkInfoGetAllModel(
        id: park.id,
        // city: 'İstanbul',
        // enable: false,
        // isOpen: true,
        // lat: 1231,
        // lng: 123,
        // parkType: 'Kapalı',
        parkName: _parkNameController.text,
        district: _districtController.text,
        freeTime: int.parse(_freeTimeController.text),
        workHours: _workHoursController.text,
        capacity: int.parse(_capacityController.text),
        emptyCapacity: int.parse(_emptyCapacityController.text));
    return updatedModel;
  }

  Future<bool?> _confirmedDeleteShowDialog(
      BuildContext context, ParkInfoGetAllModel park) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText = park.parkName ?? 'Delete';
        var dialogBodyBlackAndColorText = 'Do you want to delete?';
        var buttonOK2 = 'YES';
        var buttonCancel2 = 'Cancel';

        return ConfirmDeleteDialog(
          dialogHeaderBlackText: dialogHeaderBlackAndColorText,
          dialogHeaderColorText: dialogHeaderBlackAndColorText,
          dialogBodyBlackText: dialogBodyBlackAndColorText,
          dialogBodyColorText: dialogBodyBlackAndColorText,
          buttonOK: buttonOK2,
          buttonCancel: buttonCancel2,
          onPressed: () {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }
}

Future<bool?> _openParkDetailShowDialog(
    BuildContext context, ParkInfoGetAllModel park) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      var dialogHeaderBlackAndColorText = park.parkName ?? 'Delete';
      var dialogBodyBlackAndColorText = 'Do you want to update?';
      var buttonOK2 = 'YES';
      var buttonCancel2 = 'Cancel';
      return OpenParkDetailShowDialog(
        dialogHeaderBlackText: dialogHeaderBlackAndColorText,
        dialogHeaderColorText: dialogHeaderBlackAndColorText,
        dialogBodyBlackText: dialogBodyBlackAndColorText,
        dialogBodyColorText: dialogBodyBlackAndColorText,
        buttonOK: buttonOK2,
        buttonCancel: buttonCancel2,
        icon: Icons.drive_file_rename_outline_sharp,
        onPressed: () {
          Navigator.pop(context, true);
        },
      );
    },
  );
}

class UpdateRow extends StatefulWidget {
  final ParkInfoGetAllModel park;

  final Function onFetchPostItems;
  final Function? onDeletePark;

  const UpdateRow(
      {Key? key,
      required this.park,
      required this.onFetchPostItems,
      this.onDeletePark})
      : super(key: key);

  @override
  State<UpdateRow> createState() => _UpdateRowState();
}

class _UpdateRowState extends State<UpdateRow> {
  late final ParkInfoGetAllModel park;
  late final IParkPostService _parkPostService;
  late final Function? onFetchPostItems;
  late final Function onDeletePark;

  final TextEditingController _parkNameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _freeTimeController = TextEditingController();
  final TextEditingController _workHoursController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _emptyCapacityController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    park = widget.park;
    onFetchPostItems = widget.onFetchPostItems;
    onDeletePark = widget.onDeletePark!;
    _parkNameController.text = widget.park.parkName!;
    _districtController.text = widget.park.district!;
    _freeTimeController.text = widget.park.freeTime!.toString();
    _workHoursController.text = widget.park.workHours!.toString();
    _capacityController.text = widget.park.capacity!.toString();
    _emptyCapacityController.text = widget.park.emptyCapacity!.toString();
    _parkPostService = ParkPostService();
  }

  Future<void> updateParkInfo(ParkInfoGetAllModel updatedModel) async {
    await _parkPostService.putItemToService(updatedModel, context);
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
                    controller: _parkNameController,
                    cursorColor: Colors.amber,
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
                        controller: _districtController,
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
                        controller: _freeTimeController,
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
                        controller: _workHoursController,
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
                        controller: _capacityController,
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
                        controller: _emptyCapacityController,
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
                                      Size(490, 50))),
                              onPressed: () async {
                                bool? confirmed =
                                    await _openParkDetailShowDialog(
                                        context, park);
                                if (confirmed == true) {
                                  ParkInfoGetAllModel updatedModel =
                                      _updatedModel();

                                  await updateParkInfo(updatedModel);
                                  await widget.onFetchPostItems();
                                  Navigator.pop(context, true);
                                } else {
                                  print('cancel');
                                }
                              },
                              child: const Text('Update')),
                          ElevatedButton(
                            style: _buttonStyle(),
                            onPressed: () async {
                              bool? confirmed =
                                  await _confirmedDeleteShowDialog(
                                      context, park);
                              if (confirmed == true) {
                                await widget.onDeletePark!(park.id);
                                await widget.onFetchPostItems();
                                Navigator.pop(context, true);
                              } else {
                                print('cancel');
                              }
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

  ParkInfoGetAllModel _updatedModel() {
    ParkInfoGetAllModel updatedModel = ParkInfoGetAllModel(
        id: park.id,
        // city: 'İstanbul',
        // enable: false,
        // isOpen: true,
        // lat: 1231,
        // lng: 123,
        // parkType: 'Kapalı',
        parkName: _parkNameController.text,
        district: _districtController.text,
        freeTime: int.parse(_freeTimeController.text),
        workHours: _workHoursController.text,
        capacity: int.parse(_capacityController.text),
        emptyCapacity: int.parse(_emptyCapacityController.text));
    return updatedModel;
  }

  Future<bool?> _confirmedDeleteShowDialog(
      BuildContext context, ParkInfoGetAllModel park) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText = park.parkName ?? 'Delete';
        var dialogBodyBlackAndColorText = 'Do you want to delete?';
        var buttonOK2 = 'YES';
        var buttonCancel2 = 'Cancel';

        return ConfirmDeleteDialog(
          dialogHeaderBlackText: dialogHeaderBlackAndColorText,
          dialogHeaderColorText: dialogHeaderBlackAndColorText,
          dialogBodyBlackText: dialogBodyBlackAndColorText,
          dialogBodyColorText: dialogBodyBlackAndColorText,
          buttonOK: buttonOK2,
          buttonCancel: buttonCancel2,
          onPressed: () {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }
}

ButtonStyle _buttonStyle() {
  return const ButtonStyle(
      fixedSize: MaterialStatePropertyAll(Size(100, 50)),
      backgroundColor: MaterialStatePropertyAll(Colors.black12));
}
