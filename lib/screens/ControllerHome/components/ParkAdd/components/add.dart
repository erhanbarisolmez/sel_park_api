import 'package:flutter/material.dart';
import 'package:self_park/core/services/post_parkInfo_service.dart';

import '../../../../../core/models/Park/ParkInfoGetModel.dart';
import '../../../../../core/widgets/DropDownButton2.dart';
import '../../../../../core/widgets/confirmedDeleteShowDialog.dart';
import '../../../../../core/widgets/google_maps.dart';
import '../../../../../language/language_items.dart';
import 'postgresql/list.dart';

class AddParkView extends StatefulWidget {
  const AddParkView({super.key});

  @override
  State<AddParkView> createState() => _AddViewHomeState();
}

class _AddViewHomeState extends State<AddParkView> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait
            ? const AddParkColumn()
            : const AddParkRow(),
      ),
    );
  }
}

class AddParkColumn extends StatefulWidget {
  const AddParkColumn({Key? key}) : super(key: key);

  @override
  State<AddParkColumn> createState() => _AddParkColumnState();
}

class _AddParkColumnState extends State<AddParkColumn> {
  late final IParkPostService _parkPostService;
  final TextEditingController _parkName = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _workHours = TextEditingController();
  final TextEditingController _freeTime = TextEditingController();
  final TextEditingController _capacity = TextEditingController();
  final TextEditingController _emptyCapacity = TextEditingController();
  final TextEditingController _lng = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final List<String> items = <String>[
    'AÇIK',
    'KAPALI',
  ];
  String? selectedValue;

  late final ParkInfoGetAllModel park;
  String lat = "";
  String lng = "";

  @override
  void initState() {
    super.initState();
    _parkPostService = ParkPostService();
  }

  @override
  void dispose() {
    _parkName.dispose();
    _district.dispose();
    _workHours.dispose();
    _freeTime.dispose();
    _capacity.dispose();
    _emptyCapacity.dispose();
    super.dispose();
  }

  void navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ListParkView();
        },
      ),
    );
  }

  Future<void> addNewPark(ParkInfoGetAllModel newPost) async {
    await _parkPostService.addNewItemToParkService(newPost, context);
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
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    child: Text(
                      'Add Park',
                      style: TextStyle(color: Colors.amber, fontSize: 28),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  SizedBox(
                    width: 600,
                    child: ParkNameTextWidget(parkName: _parkName),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 600,
                        child: CityTextWidget(city: _city),
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
                        width: 270,
                        child: DistrictTextWidget(district: _district),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      SizedBox(
                        width: 160,
                        child: FreeTimeTextWidget(freeTime: _freeTime),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      SizedBox(
                        width: 160,
                        child: WorkHoursTextWidget(workHours: _workHours),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            child: GestureDetector(
                              onDoubleTap: () async {
                                Map<String, double>? result =
                                    await Navigator.push<Map<String, double>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      latitude: double.tryParse(lat),
                                      longitude: double.tryParse(lng),
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    lat = result['latitude'].toString();
                                    lng = result['longitude'].toString();

                                    _lat.text = lat;
                                    _lng.text = lng;
                                  });
                                }
                              },
                              child: LngTextWidget(lng: _lng),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 6)),
                          SizedBox(
                            width: 160,
                            child: GestureDetector(
                              onDoubleTap: () async {
                                String initialLat = _lat.text;
                                String initialLng = _lng.text;

                                Map<String, double>? result =
                                    await Navigator.push<Map<String, double>>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                            latitude: initialLat,
                                            longitude: initialLng,
                                          )),
                                );
                                if (result != null) {
                                  setState(() {
                                    _lat.text = result['latitude'].toString();
                                    _lng.text = result['longitude'].toString();
                                  });
                                }
                              },
                              child: LatTextWidget(lat: _lat),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 6)),
                          SizedBox(
                              height: 58,
                              width: 270,
                              child: SingleChildScrollView(
                                child: CustomDropdownButton2(
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hint: selectedValue ?? 'Park Type',
                                  iconEnabledColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  iconSize: 25,
                                  value: selectedValue,
                                  dropdownItems: items,
                                  onChanged: (value) {
                                    selectedValue = value;
                                  },
                                ),
                              )),
                        ],
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
                        child: CapacityTextWidget(capacity: _capacity),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 6)),
                      SizedBox(
                        width: 297,
                        child: EmptyCapacityTextWidget(
                            emptyCapacity: _emptyCapacity),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(600, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black12),
                        ),
                        onPressed: () async {
                          if (_parkName.text.isNotEmpty &&
                              _district.text.isNotEmpty &&
                              _capacity.text.isNotEmpty &&
                              _emptyCapacity.text.isNotEmpty &&
                              _freeTime.text.isNotEmpty &&
                              _workHours.text.isNotEmpty &&
                              _lng.text.isNotEmpty &&
                              _lat.text.isNotEmpty &&
                              selectedValue != null) {
                            bool? confirmed =
                                await _confirmedAddShowDialog(context);
                            if (confirmed == true) {
                              ParkInfoGetAllModel newPost = _newPost();
                              await addNewPark(newPost);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context, true);
                            }
                          } else {
                            print('cancel');
                          }
                        },
                        child: const Text(
                          'Add',
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmedAddShowDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText = _parkName.text ?? 'Add';
        var dialogBodyBlackAndColorText = 'Do you want to add?';
        var buttonOK2 = 'YES';
        var buttonCancel2 = 'Cancel';

        return ConfirmDeleteDialog(
          dialogHeaderBlackText: dialogHeaderBlackAndColorText,
          dialogHeaderColorText: dialogHeaderBlackAndColorText,
          dialogBodyBlackText: dialogBodyBlackAndColorText,
          dialogBodyColorText: dialogBodyBlackAndColorText,
          buttonOK: buttonOK2,
          buttonCancel: buttonCancel2,
          icon: Icons.library_add_sharp,
          onPressed: () {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return const ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(100, 50)),
        backgroundColor: MaterialStatePropertyAll(Colors.black12));
  }

  ParkInfoGetAllModel _newPost() {
    ParkInfoGetAllModel newPost = ParkInfoGetAllModel(
      parkName: _parkName.text,
      district: _district.text,
      freeTime: int.parse(_freeTime.text),
      workHours: _workHours.text,
      capacity: int.parse(_capacity.text),
      emptyCapacity: int.parse(_emptyCapacity.text),
      lat: double.parse(_lat.text),
      lng: double.parse(_lng.text),
      parkType: selectedValue.toString(),
      city: _city.text,
      enable: true,
      isOpen: true,
    );
    return newPost;
  }
}

class EmptyCapacityTextWidget extends StatelessWidget {
  const EmptyCapacityTextWidget({
    super.key,
    required TextEditingController emptyCapacity,
  }) : _emptyCapacity = emptyCapacity;

  final TextEditingController _emptyCapacity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _emptyCapacity,
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.emptyCapacity,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.check_box_outline_blank_sharp),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class CapacityTextWidget extends StatelessWidget {
  const CapacityTextWidget({
    super.key,
    required TextEditingController capacity,
  }) : _capacity = capacity;

  final TextEditingController _capacity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _capacity,
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.capacity,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.check_box_outlined),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class LatTextWidget extends StatelessWidget {
  const LatTextWidget({
    super.key,
    required TextEditingController lat,
  }) : _lat = lat;

  final TextEditingController _lat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _lat,
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.lat,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.turn_slight_right_sharp),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class LngTextWidget extends StatelessWidget {
  const LngTextWidget({
    super.key,
    required TextEditingController lng,
  }) : _lng = lng;

  final TextEditingController _lng;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _lng,
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: LanguageItems.lng,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.turn_slight_left_sharp),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class WorkHoursTextWidget extends StatelessWidget {
  const WorkHoursTextWidget({
    super.key,
    required TextEditingController workHours,
  }) : _workHours = workHours;

  final TextEditingController _workHours;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _workHours,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.workHoursTitle,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.work_history_outlined),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class FreeTimeTextWidget extends StatelessWidget {
  const FreeTimeTextWidget({
    super.key,
    required TextEditingController freeTime,
  }) : _freeTime = freeTime;

  final TextEditingController _freeTime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _freeTime,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.freeTimeTitle,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.more_time_sharp),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class DistrictTextWidget extends StatelessWidget {
  const DistrictTextWidget({
    super.key,
    required TextEditingController district,
  }) : _district = district;

  final TextEditingController _district;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _district,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.districtTitle,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.add_location_alt_sharp),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class CityTextWidget extends StatelessWidget {
  const CityTextWidget({
    super.key,
    required TextEditingController city,
  }) : _city = city;

  final TextEditingController _city;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _city,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: LanguageItems.cityTitle,
          prefixIconColor: Colors.white,
          prefixIcon: Icon(Icons.location_city),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class ParkNameTextWidget extends StatelessWidget {
  const ParkNameTextWidget({
    super.key,
    required TextEditingController parkName,
  }) : _parkName = parkName;

  final TextEditingController _parkName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: _parkName,
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
    );
  }
}

class AddParkRow extends StatefulWidget {
  const AddParkRow({super.key});

  @override
  State<AddParkRow> createState() => _AddParkRowState();
}

class _AddParkRowState extends State<AddParkRow> {
  late final IParkPostService _parkPostService;
  final TextEditingController _parkName = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _workHours = TextEditingController();
  final TextEditingController _freeTime = TextEditingController();
  final TextEditingController _capacity = TextEditingController();
  final TextEditingController _emptyCapacity = TextEditingController();
  final TextEditingController _lng = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final List<String> items = <String>[
    'AÇIK',
    'KAPALI',
  ];
  String? selectedValue;

  late final ParkInfoGetAllModel park;
  String lat = "";
  String lng = "";

  @override
  void initState() {
    super.initState();
    _parkPostService = ParkPostService();
  }

  @override
  void dispose() {
    _parkName.dispose();
    _district.dispose();
    _workHours.dispose();
    _freeTime.dispose();
    _capacity.dispose();
    _emptyCapacity.dispose();
    super.dispose();
  }

  void navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ListParkView();
        },
      ),
    );
  }

  Future<void> addNewPark(ParkInfoGetAllModel newPost) async {
    await _parkPostService.addNewItemToParkService(newPost, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        child: Text(
                          'Add Park',
                          style: TextStyle(color: Colors.amber, fontSize: 28),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      SizedBox(
                        width: 600,
                        child: ParkNameTextWidget(parkName: _parkName),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 600,
                            child: CityTextWidget(city: _city),
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
                            width: 270,
                            child: DistrictTextWidget(district: _district),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          SizedBox(
                            width: 160,
                            child: FreeTimeTextWidget(freeTime: _freeTime),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          SizedBox(
                            width: 160,
                            child: WorkHoursTextWidget(workHours: _workHours),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 160,
                                child: GestureDetector(
                                  onDoubleTap: () async {
                                    Map<String, double>? result =
                                        await Navigator.push<
                                            Map<String, double>>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen(
                                          latitude: double.tryParse(lat),
                                          longitude: double.tryParse(lng),
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        lat = result['latitude'].toString();
                                        lng = result['longitude'].toString();

                                        _lat.text = lat;
                                        _lng.text = lng;
                                      });
                                    }
                                  },
                                  child: LngTextWidget(lng: _lng),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 6)),
                              SizedBox(
                                width: 160,
                                child: GestureDetector(
                                  onDoubleTap: () async {
                                    String initialLat = _lat.text;
                                    String initialLng = _lng.text;

                                    Map<String, double>? result =
                                        await Navigator.push<
                                            Map<String, double>>(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen(
                                                latitude: initialLat,
                                                longitude: initialLng,
                                              )),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        _lat.text =
                                            result['latitude'].toString();
                                        _lng.text =
                                            result['longitude'].toString();
                                      });
                                    }
                                  },
                                  child: LatTextWidget(lat: _lat),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 6)),
                              SizedBox(
                                  height: 58,
                                  width: 270,
                                  child: CustomDropdownButton2(
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hint: selectedValue ?? 'Park Type',
                                    iconEnabledColor:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    iconSize: 25,
                                    value: selectedValue,
                                    dropdownItems: items,
                                    onChanged: (value) {
                                      selectedValue = value;
                                    },
                                  )),
                            ],
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
                            child: CapacityTextWidget(capacity: _capacity),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 6)),
                          SizedBox(
                            width: 297,
                            child: EmptyCapacityTextWidget(
                                emptyCapacity: _emptyCapacity),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                              fixedSize:
                                  MaterialStatePropertyAll(Size(600, 50)),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black12),
                            ),
                            onPressed: () async {
                              if (_parkName.text.isNotEmpty &&
                                  _district.text.isNotEmpty &&
                                  _capacity.text.isNotEmpty &&
                                  _emptyCapacity.text.isNotEmpty &&
                                  _freeTime.text.isNotEmpty &&
                                  _workHours.text.isNotEmpty &&
                                  _lng.text.isNotEmpty &&
                                  _lat.text.isNotEmpty &&
                                  selectedValue != null) {
                                bool? confirmed =
                                    await _confirmedAddShowDialog(context);
                                if (confirmed == true) {
                                  ParkInfoGetAllModel newPost = _newPost();
                                  await addNewPark(newPost);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context, true);
                                }
                              } else {
                                print('cancel');
                              }
                            },
                            child: const Text(
                              'Add',
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmedAddShowDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText = _parkName.text ?? 'Add';
        var dialogBodyBlackAndColorText = 'Do you want to add?';
        var buttonOK2 = 'YES';
        var buttonCancel2 = 'Cancel';

        return ConfirmDeleteDialog(
          dialogHeaderBlackText: dialogHeaderBlackAndColorText,
          dialogHeaderColorText: dialogHeaderBlackAndColorText,
          dialogBodyBlackText: dialogBodyBlackAndColorText,
          dialogBodyColorText: dialogBodyBlackAndColorText,
          buttonOK: buttonOK2,
          buttonCancel: buttonCancel2,
          icon: Icons.library_add_sharp,
          onPressed: () {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return const ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(100, 50)),
        backgroundColor: MaterialStatePropertyAll(Colors.black12));
  }

  ParkInfoGetAllModel _newPost() {
    ParkInfoGetAllModel newPost = ParkInfoGetAllModel(
      parkName: _parkName.text,
      district: _district.text,
      freeTime: int.parse(_freeTime.text),
      workHours: _workHours.text,
      capacity: int.parse(_capacity.text),
      emptyCapacity: int.parse(_emptyCapacity.text),
      lat: double.parse(_lat.text),
      lng: double.parse(_lng.text),
      parkType: selectedValue.toString(),
      city: _city.text,
      enable: true,
      isOpen: true,
    );
    return newPost;
  }
}

  // harita göstermek için  'package:google_maps_flutter/google_maps_flutter.dart';
  // ispark apisinden park konumları çekilecek.
  // konum almak ve izleme için import 'package:location/location.dart';
