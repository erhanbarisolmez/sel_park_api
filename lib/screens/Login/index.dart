import 'package:flutter/material.dart';
import 'package:self_park/screens/Login/components/operator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double toolbarHeight2 = 100;

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: toolbarHeight2,
          title: Padding(
            padding: _PaddingUtility().logoPadding,
            child: Expanded(
              child: _Image().imageLogo,
            ),
          ),
          bottom: _myTabView(context),
        ),
        body: deviceOrientation == Orientation.portrait
            ? _tabbarView()
            : _tabbarViewRow(),
      ),
    );
  }

  TabBar _myTabView(BuildContext context) {
    return TabBar(
      onTap: (int index) {
        print(index);
      },
      indicatorColor: _ColorsUtility().shade3002,
      labelStyle: Theme.of(context).textTheme.headlineSmall,
      tabs: const [SizedBox()],
    );
  }

  TabBarView _tabbarView() {
    return const TabBarView(
        physics: NeverScrollableScrollPhysics(), children: [Operator()]);
  }

  TabBarView _tabbarViewRow() {
    return const TabBarView(
        physics: NeverScrollableScrollPhysics(), children: [Operator()]);
  }
}

// ignore: constant_identifier_names
enum _MyTabViews { Login }

//extension _MyTabVieExtension on _MyTabViews {}

class _ColorsUtility {
  final shade3002 = Colors.amber.shade300;
  final grey300 = Colors.grey[300];
}

class _PaddingUtility {
  final logoPadding = const EdgeInsets.only(top: 50);
  final normalPadding = const EdgeInsets.all(8.0);
}

class _Image {
  final imageLogo = Image.network(
      'https://www.selftech-tr.com/wp-content/uploads/2022/05/stl5555-2.png');
}
