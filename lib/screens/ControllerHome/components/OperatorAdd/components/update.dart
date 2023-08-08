import 'package:flutter/material.dart';
import 'package:self_park/core/db/connect.dart';
import 'package:self_park/language/language_items.dart' show LanguageItems;

class UpdateViewHome extends StatefulWidget {
  const UpdateViewHome({Key? key}) : super(key: key);

  @override
  State<UpdateViewHome> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateViewHome> {
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
  late User user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  void onNameChanged(String value) {
    setState(() {
      user.name = value;
    });
  }

  void onEmailChanged(String value) {
    setState(() {
      user.email = value;
    });
  }

  void onPasswordChanged(String value) {
    setState(() {
      user.password = value;
    });
  }

  Future<void> searchUser(String retrievedEmail) async {
    final connect = await connectToDB();
    final queryResult = await connect?.query(
        'SELECT name, email, password FROM tbl_user WHERE email = @email',
        substitutionValues: {'email': retrievedEmail});

    if (queryResult != null && queryResult.isNotEmpty) {
      final row = queryResult.first;

      final retrievedName = row[0] as String;
      final retrievedEmail = row[1] as String;
      final retrievedPassword = row[2] as String;

      setState(() {
        user = User(
          name: retrievedName,
          email: retrievedEmail,
          password: retrievedPassword,
        );
        nameController.text = retrievedName;
        emailController.text = retrievedEmail;
        passwordController.text = retrievedPassword;
      });
    } else {
      setState(() {
        user = User(name: '', email: '', password: '');
        nameController.text = '';
        emailController.text = '';
        passwordController.text = '';
      });
    }

    await connect?.close();
  }

  Future<bool> updateUser() async {
    final connect = await connectToDB();
    await connect?.execute(
      'UPDATE tbl_user SET name = @name, password = @password WHERE email = @email',
      substitutionValues: {
        'name': user.name,
        'password': user.password,
        'email': user.email,
      },
    );

    setState(() {
      user = User(name: '', email: '', password: '');
      nameController = TextEditingController();
      emailController = TextEditingController();
      passwordController = TextEditingController();
    });

    await connect?.close();
    return true;
  }

  @override
  void initState() {
    super.initState();
    user = User(name: '', email: '', password: '');
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
                    'Edit Operator',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: emailController,
                    onChanged: onEmailChanged,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.mailTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.mail_outline),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: nameController,
                    onChanged: onNameChanged,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.nameTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.person_2),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: passwordController,
                    onChanged: onPasswordChanged,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.passwordTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.password_outlined),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: _buttonStyle(),
                            onPressed: () {
                              searchUser(user.email);
                            },
                            child: const Text('Search'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: _buttonStyle().copyWith(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(400, 50),
                              ),
                            ),
                            onPressed: () async {
                              String nameText = nameController.text;
                              String emailText = emailController.text;
                              String passwordText = passwordController.text;

                              if (nameText.isNotEmpty &&
                                  emailText.isNotEmpty &&
                                  passwordText.isNotEmpty) {
                                bool edit = await updateUser();
                                if (edit) {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Success'),
                                        content: const Text('Update success.'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
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
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Please fill in all fields.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
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
  late User user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  void onNameChanged(String value) {
    setState(() {
      user.name = value;
    });
  }

  void onEmailChanged(String value) {
    setState(() {
      user.email = value;
    });
  }

  void onPasswordChanged(String value) {
    setState(() {
      user.password = value;
    });
  }

  Future<void> searchUser(String retrievedEmail) async {
    final connect = await connectToDB();
    final queryResult = await connect?.query(
        'SELECT name, email, password FROM tbl_user WHERE email = @email',
        substitutionValues: {'email': retrievedEmail});

    if (queryResult != null && queryResult.isNotEmpty) {
      final row = queryResult.first;

      final retrievedName = row[0] as String;
      final retrievedEmail = row[1] as String;
      final retrievedPassword = row[2] as String;

      setState(() {
        user = User(
          name: retrievedName,
          email: retrievedEmail,
          password: retrievedPassword,
        );
        nameController.text = retrievedName;
        emailController.text = retrievedEmail;
        passwordController.text = retrievedPassword;
      });
    } else {
      setState(() {
        user = User(name: '', email: '', password: '');
        nameController.text = '';
        emailController.text = '';
        passwordController.text = '';
      });
    }

    await connect?.close();
  }

  Future<bool> updateUser() async {
    final connect = await connectToDB();
    await connect?.execute(
      'UPDATE tbl_user SET name = @name, password = @password WHERE email = @email',
      substitutionValues: {
        'name': user.name,
        'password': user.password,
        'email': user.email,
      },
    );

    setState(() {
      user = User(name: '', email: '', password: '');
      nameController = TextEditingController();
      emailController = TextEditingController();
      passwordController = TextEditingController();
    });

    await connect?.close();
    return true;
  }

  @override
  void initState() {
    super.initState();
    user = User(name: '', email: '', password: '');
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
                    'Edit Operator',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: emailController,
                    onChanged: onEmailChanged,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.mailTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.mail_outline),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: nameController,
                    onChanged: onNameChanged,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.nameTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.person_2),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: passwordController,
                    onChanged: onPasswordChanged,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: LanguageItems.passwordTitle,
                      prefixIconColor: Colors.white,
                      prefixIcon: Icon(Icons.password_outlined),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: _buttonStyle(),
                            onPressed: () {
                              searchUser(user.email);
                            },
                            child: const Text('Search'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: _buttonStyle().copyWith(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(400, 50),
                              ),
                            ),
                            onPressed: () async {
                              String nameText = nameController.text;
                              String emailText = emailController.text;
                              String passwordText = passwordController.text;

                              if (nameText.isNotEmpty &&
                                  emailText.isNotEmpty &&
                                  passwordText.isNotEmpty) {
                                bool edit = await updateUser();
                                if (edit) {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Success'),
                                        content: const Text('Update success.'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
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
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Please fill in all fields.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
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
    fixedSize: MaterialStatePropertyAll(Size(190, 50)),
    backgroundColor: MaterialStatePropertyAll(Colors.black12),
  );
}

class User {
  String name;
  String email;
  String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });
}
