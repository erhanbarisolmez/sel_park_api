import 'package:flutter/material.dart';
import 'package:self_park/language/language_items.dart';
import 'package:self_park/screens/ControllerHome/components/OperatorAdd/components/add.dart';
import 'package:self_park/screens/ControllerHome/components/OperatorAdd/components/list.dart';
import 'package:self_park/screens/ControllerHome/components/OperatorAdd/components/update.dart';

class OperatorAdd extends StatefulWidget {
  const OperatorAdd({super.key});

  @override
  State<OperatorAdd> createState() => _OperatorAddState();
}

class _OperatorAddState extends State<OperatorAdd> {
  final _pageController = PageController(viewportFraction: 1);

  int _currentPageIndex = 0;
  void _updatePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          const Padding(
            padding: _PaddingUtility.onlyLeft,
            //child: Text(_currentPageIndex.toString()),
          ),
          const Spacer(),
          FloatingActionButton(
            heroTag: LanguageItems.heroPreviousTitle,
            onPressed: () {
              _pageController.previousPage(
                  duration: _DurationUtility._durationLow,
                  curve: Curves.decelerate);
            },
            backgroundColor: _ColorsUtility._amber,
            child: const Icon(Icons.chevron_left_rounded),
          ),
          Padding(
            padding: _PaddingUtility.generic,
            child: FloatingActionButton(
              heroTag: LanguageItems.heroNextTitle,
              onPressed: () {
                _pageController.nextPage(
                    duration: _DurationUtility._durationLow,
                    curve: Curves.decelerate);
              },
              backgroundColor: _ColorsUtility._amber,
              child: const Icon(Icons.chevron_right_rounded),
            ),
          )
        ],
      ),
      body: PageView(
        padEnds: false,
        controller: _pageController,
        onPageChanged: _updatePageIndex,
        children: const [
          AddViewHome(),
          ListViewHome(), //ListViewHome MainPage
          UpdateViewHome(),
        ],
      ),
    );
  }
}

class _DurationUtility {
  static const _durationLow = Duration(seconds: 1);
}

class _ColorsUtility {
  static const _amber = Colors.amber;
}

class _PaddingUtility {
  static const onlyLeft = EdgeInsets.only(left: 20);
  static const generic = EdgeInsets.all(8.0);
}
