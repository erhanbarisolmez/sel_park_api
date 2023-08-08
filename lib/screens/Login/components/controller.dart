import 'package:flutter/material.dart';
import 'package:self_park/core/db/query/controller/login/loginQuery.dart';
import 'package:self_park/screens/ControllerHome/index.dart';

import '../../../language/language_items.dart';

class Controller extends StatelessWidget {
  const Controller({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait
            ? const MyColumn()
            : const MyRow(),
      ),
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    var _email = TextEditingController();
    var _password = TextEditingController();
    return Padding(
      padding: _PaddingUtility().normalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: LanguageItems.mailTitle,
                  prefixIconColor: Colors.white,
                  prefixIcon: Icon(Icons.mail_lock_outlined),
                  focusedBorder: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 600,
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: LanguageItems.passwordTitle,
                  prefixIconColor: Colors.white,
                  prefixIcon: Icon(Icons.password_outlined),
                  focusedBorder: OutlineInputBorder()),
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
                String email = _email.text;
                String password = _password.text;
                bool isAuthenticated = await authenticateAdmin(
                    email, password); // Kullanıcıyı doğrula
                if (isAuthenticated) {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const ControllerHome()));
                } else {
                  // Kimlik doğrulaması başarısız
                  showDialog(
                    context: (context),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Controller mail or password is incorrect.'),
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
              },
              child: const Text(
                'Admin',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    var _email = TextEditingController();
    var _password = TextEditingController();
    return Padding(
      padding: _PaddingUtility().normalPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: LanguageItems.mailTitle,
                  prefixIconColor: Colors.white,
                  prefixIcon: Icon(Icons.mail_lock_outlined),
                  focusedBorder: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 600,
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: LanguageItems.passwordTitle,
                  prefixIconColor: Colors.white,
                  prefixIcon: Icon(Icons.password_outlined),
                  focusedBorder: OutlineInputBorder()),
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
                String email = _email.text;
                String password = _password.text;
                bool isAuthenticated = await authenticateAdmin(
                    email, password); // Kullanıcıyı doğrula
                if (isAuthenticated) {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const ControllerHome()));
                } else {
                  // Kimlik doğrulaması başarısız
                  showDialog(
                    context: (context),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Controller mail or password is incorrect.'),
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
              },
              child: const Text(
                'Admin',
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
