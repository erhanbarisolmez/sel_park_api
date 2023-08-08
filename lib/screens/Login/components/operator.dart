import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_park/screens/OperatorHome/index.dart';

import '../../../core/services/auth_provider.dart';
import '../../../language/language_items.dart';
import '../../ControllerHome/index.dart';

class Operator extends StatefulWidget {
  const Operator({Key? key}) : super(key: key);

  @override
  _OperatorState createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  Orientation? deviceOrientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    deviceOrientation = MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait ? MyColumn() : MyRow(),
      ),
    );
  }
}

class MyColumn extends StatefulWidget {
  const MyColumn({Key? key}) : super(key: key);

  @override
  _MyColumnState createState() => _MyColumnState();
}

class _MyColumnState extends State<MyColumn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    final email = _emailController.text.toString();
    final password = _passwordController.text.toString();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.authenticate(email, password);
      if (authProvider.role == 'ADMIN') {
        print('admin');
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ControllerHome()));
      } else if (authProvider.role == 'USER') {
        print('user');
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OperatorHome()));
        //  Navigator.pushReplacement(context, '/operator' as Route<Object?>);
      } else {
        print('rol hatalı');
      }
    } catch (e) {
      print('Login hata: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _PaddingUtility().normalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: LanguageItems.mailTitle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.mail_lock_outlined),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 600,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: LanguageItems.passwordTitle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.password_outlined),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () async {
                handleLogin();
                // Handle login logic using _emailController.text and _passwordController.text
              },
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyRow extends StatefulWidget {
  const MyRow({Key? key}) : super(key: key);

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    final email = _emailController.text.toString();
    final password = _passwordController.text.toString();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.authenticate(email, password);
      if (authProvider.role == 'ADMIN') {
        print('admin');
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ControllerHome()));
      } else if (authProvider.role == 'USER') {
        print('user');
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OperatorHome()));
        //  Navigator.pushReplacement(context, '/operator' as Route<Object?>);
      } else {
        print('rol hatalı');
      }
    } catch (e) {
      print('Login hata: ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _PaddingUtility().normalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: LanguageItems.mailTitle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.mail_lock_outlined),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 600,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: LanguageItems.passwordTitle,
                prefixIconColor: Colors.white,
                prefixIcon: Icon(Icons.password_outlined),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () async {
                handleLogin();
                // Handle login logic using _emailController.text and _passwordController.text
              },
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaddingUtility {
  final logoPadding = const EdgeInsets.only(top: 20);
  final normalPadding = const EdgeInsets.all(8.0);
}
