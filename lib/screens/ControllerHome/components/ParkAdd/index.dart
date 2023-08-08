import 'package:flutter/material.dart';
import 'package:self_park/language/language_items.dart';
import 'package:self_park/screens/ControllerHome/components/ParkAdd/components/add.dart';

import 'components/list.dart';

class ParkAdd extends StatefulWidget {
  const ParkAdd({super.key});

  @override
  State<ParkAdd> createState() => _ParkAddState();
}

class _ParkAddState extends State<ParkAdd> {
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(viewportFraction: 1);
    return Scaffold(
      floatingActionButton: Row(
        children: [
          const Padding(
            padding: _PaddingUtility._onlyleft,
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
            padding: _PaddingUtility._generic,
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
          ),
        ],
      ),
      body: PageView(
        padEnds: false,
        controller: _pageController,
        children: const [
          AddParkView(),
          ListParkView(),
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
  static const _onlyleft = EdgeInsets.only(left: 20);
  static const _generic = EdgeInsets.all(8.0);
}
