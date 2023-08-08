import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:self_park/core/services/auth_provider.dart';
import 'package:self_park/screens/Login/index.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _AppbarTheme()._apbarTheme,
        home: const Scaffold(
          body: LoginPage(), //LoginPage  ListParkView
        ),
      ),
    );
  }
}

class _AppbarTheme {
  final _apbarTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

// Flutter 3.10.2 • channel stable • https://github.com/flutter/flutter.git
// Framework • revision 9cd3d0d9ff (9 weeks ago) • 2023-05-23 20:57:28 -0700
// Engine • revision 90fa3ae28f
// Tools • Dart 3.0.2 • DevTools 2.23.1

