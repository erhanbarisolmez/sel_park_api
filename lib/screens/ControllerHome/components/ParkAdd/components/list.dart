import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:self_park/core/services/auth_provider.dart';
import 'package:self_park/screens/ControllerHome/components/ParkAdd/components/edit.dart';

import '../../../../../core/models/Park/ParkInfoGetModel.dart';
import '../../../../../core/services/post_parkInfo_service.dart';
import '../../../../../core/widgets/confirmedDeleteShowDialog.dart';

class ListParkView extends StatefulWidget {
  const ListParkView({Key? key}) : super(key: key);

  @override
  State<ListParkView> createState() => _ListParkViewState();
}

class _ListParkViewState extends State<ListParkView> {
  late final IParkPostService _parkPostService;
  List<ParkInfoGetAllModel>? _items;
  List<ParkInfoGetAllModel>? _searchList = [];
  late final TextEditingController _searchController = TextEditingController();

  String? title;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();

    _parkPostService = ParkPostService();
    fetchPostItems();
    title = 'Park List';
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      if (searchText.isEmpty) {
        _searchList = _items;
      } else {
        _searchList = _items
            ?.where((park) =>
                park.parkName!.toLowerCase().contains(searchText) ||
                park.district!.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  Stream<List<ParkInfoGetAllModel>> parkListStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield _items ?? [];
    }
  }

  Future<List<ParkInfoGetAllModel>?> fetchPostItems() async {
    _items = await _parkPostService.fetchPostItems(context);
    _searchList = _items;
    return _searchList != null ? _searchList! : [];
  }

  Future<void> deletePark(id) async {
    await _parkPostService.deleteItemToParkService(id, context);
    if (mounted) {
      setState(() {
        _items?.removeWhere((item) => item.id == id);
        _searchList?.removeWhere((item) => item.id == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
          actions: [
            _isloading
                ? const CircularProgressIndicator.adaptive()
                : const SizedBox.shrink(),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SearchBar(
                      controller: _searchController,
                      hintText: 'Search',
                      trailing: [
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                              onPressed: () {
                                _searchController.clear();
                              },
                              icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<ParkInfoGetAllModel>>(
            stream: parkListStream(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ParkInfoGetAllModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  'No parks found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ));
              } else {
                final park = snapshot.data;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  itemCount: _searchList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final park = _searchList![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(park.parkName ?? ''),
                        leading: Icon(
                          Icons.local_parking,
                          size: 50,
                          color: Colors.yellow.shade100,
                        ),
                        subtitle: Text(' ${park.district ?? ''} '),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  navigateToEdit(context, park);
                                },
                                icon: Icon(
                                  Icons.mode_edit,
                                  color: Colors.orange.shade100,
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.orange.shade100,
                                  size: 28,
                                ),
                                onPressed: () async {
                                  bool? confirmed =
                                      await _confirmedDeleteShowDialog(
                                          context, park);
                                  if (confirmed == true) {
                                    print(confirmed);
                                    // ignore: use_build_context_synchronously
                                  } else {
                                    print('cancel');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () => openParkDetail(context, park),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
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
            deletePark(park.id);
            Navigator.pop(context, true);
          },
        );
      },
    );
  }

  void openParkDetail(BuildContext context, ParkInfoGetAllModel park) {
    showDialog(
      context: context,
      builder: (context) {
        const iconRename = Icons.drive_file_rename_outline_sharp;
        return SimpleDialog(
          title: Stack(
            children: <Widget>[
              Text(park.parkName ?? '', style: _dialogHeaderBlackTextStyle()),
              Text(
                park.parkName ?? '',
                style: _dialogHeaderColorTextStyle(),
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
                      Icon(iconRename, size: 50, color: Colors.yellow.shade100),
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
                        style: _butttonStyleOK(),
                        onPressed: () {
                          navigateToEdit(context, park);
                        },
                        child: Text('Edit', style: _textButtonStyleOK())),
                    TextButton(
                      style: _buttonStyleCancel(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: _textButtonStyleCancel(),
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

  TextStyle _textButtonStyleCancel() {
    return GoogleFonts.rajdhani(
        color: Colors.orange.shade100,
        fontSize: 18,
        fontWeight: FontWeight.bold);
  }

  ButtonStyle _buttonStyleCancel() {
    return TextButton.styleFrom(
        backgroundColor: Colors.transparent, minimumSize: const Size(200, 50));
  }

  TextStyle _textButtonStyleOK() {
    return GoogleFonts.rajdhani(
        color: const Color(0xffffffff),
        fontSize: 18,
        fontWeight: FontWeight.bold);
  }

  ButtonStyle _butttonStyleOK() {
    return TextButton.styleFrom(
        backgroundColor: Colors.black38, minimumSize: const Size(200, 50));
  }

  TextStyle _dialogHeaderColorTextStyle() {
    return TextStyle(
      fontSize: 30,
      color: Colors.grey[300],
      letterSpacing: 2,
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle _dialogHeaderBlackTextStyle() {
    return TextStyle(
      fontSize: 30,
      letterSpacing: 2,
      fontWeight: FontWeight.w800,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.black45!,
    );
  }

  List<Widget> _cardText(ParkInfoGetAllModel park) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Text(
                'District= ${park.district}',
                style: _dialogBodyBlackTextStyle(),
              ),
              Text(
                'District= ${park.district}',
                style: _dialogBodyColorTextStyle(),
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

  TextStyle _dialogBodyColorTextStyle() {
    return TextStyle(
      fontSize: 20,
      color: Colors.grey[300],
      letterSpacing: 2,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle _dialogBodyBlackTextStyle() {
    return TextStyle(
        fontSize: 20,
        letterSpacing: 2,
        fontWeight: FontWeight.w700,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black!);
  }

  void navigateToEdit(BuildContext context, ParkInfoGetAllModel park) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditParkView(
          park: park,
          onFetchPostItems: fetchPostItems,
          onDeletePark: deletePark,
        ),
      ),
    );
  }
}
