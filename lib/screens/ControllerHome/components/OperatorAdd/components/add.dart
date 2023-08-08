import 'package:flutter/material.dart';
import 'package:self_park/core/services/auth_provider.dart';
import 'package:self_park/language/language_items.dart';

import '../../../../../core/models/Auth/AuthRegisterModel.dart';
import '../../../../../core/widgets/DropDownButton2.dart';
import '../../../../../core/widgets/confirmedDeleteShowDialog.dart';
import 'list.dart';

class AddViewHome extends StatefulWidget {
  const AddViewHome({super.key});

  @override
  State<AddViewHome> createState() => _AddViewState();
}

class _AddViewState extends State<AddViewHome> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
        child: deviceOrientation == Orientation.portrait
            ? const AddColumn()
            : const AddRow(),
      ),
    );
  }
}

class AddColumn extends StatefulWidget {
  const AddColumn({super.key});

  @override
  State<AddColumn> createState() => _AddColumnState();
}

class _AddColumnState extends State<AddColumn> {
  UserTextEditingControllers controllers = UserTextEditingControllers();

  final List<String> items = <String>['ADMIN', 'USER'];
  String? selectedValue;
  late final IAuthProvider _auth;
  @override
  void initState() {
    super.initState();
    _auth = AuthProvider();
  }

  @override
  void dispose() {
    super.dispose();
    controllers.firstNameController.dispose();
    controllers.lastNameController.dispose();
    controllers.emailController.dispose();
    controllers.phoneController.dispose();
    controllers.passwordController.dispose();
  }

  Future<void> register(AuthRegisterModel newUser) async {
    await _auth.registerUser(newUser, context);
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
                    'Add Operator',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.firstNameTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.person_2),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.lastNameTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.person_2),
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
                      width: 300,
                      child: TextField(
                        controller: controllers.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.mailTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.mail_outline),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.phoneController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.phoneTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.phone_android_outlined),
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
                      width: 300,
                      child: TextField(
                        controller: controllers.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.passwordTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.password_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 6)),
                    SizedBox(
                        height: 58,
                        width: 300,
                        child: CustomDropdownButton2(
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hint: selectedValue ?? 'Role',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(600, 50)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black12),
                      ),
                      onPressed: () async {
                        if (controllers.firstNameController.text.isNotEmpty &&
                            controllers.lastNameController.text.isNotEmpty &&
                            controllers.emailController.text.isNotEmpty &&
                            controllers.phoneController.text.isNotEmpty &&
                            controllers.passwordController.text.isNotEmpty &&
                            selectedValue != null) {
                          bool? confirmed =
                              await _confirmedAddShowDialog(context);
                          if (confirmed == true) {
                            AuthRegisterModel newUser = _newUser();
                            await register(newUser);
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
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmedAddShowDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText =
            controllers.firstNameController.text ?? 'Add';
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

  AuthRegisterModel _newUser() {
    AuthRegisterModel newUser = AuthRegisterModel(
      firstname: controllers.firstNameController.text,
      lastname: controllers.lastNameController.text,
      email: controllers.emailController.text,
      phone: controllers.phoneController.text,
      password: controllers.passwordController.text,
      role: selectedValue,
    );
    return newUser;
  }

  void navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ListViewHome();
        },
      ),
    );
  }
}

class AddRow extends StatefulWidget {
  const AddRow({super.key});

  @override
  State<AddRow> createState() => _AddRowState();
}

class _AddRowState extends State<AddRow> {
  UserTextEditingControllers controllers = UserTextEditingControllers();

  final List<String> items = <String>['ADMIN', 'USER'];
  String? selectedValue;
  late final IAuthProvider _auth;
  @override
  void initState() {
    super.initState();
    _auth = AuthProvider();
  }

  @override
  void dispose() {
    super.dispose();
    controllers.firstNameController.dispose();
    controllers.lastNameController.dispose();
    controllers.emailController.dispose();
    controllers.phoneController.dispose();
    controllers.passwordController.dispose();
  }

  Future<void> register(AuthRegisterModel newUser) async {
    await _auth.registerUser(newUser, context);
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
                    'Add Operator',
                    style: TextStyle(color: Colors.amber, fontSize: 28),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.firstNameTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.person_2),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.lastNameTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.person_2),
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
                      width: 300,
                      child: TextField(
                        controller: controllers.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.mailTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.mail_outline),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controllers.phoneController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.phoneTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.phone_android_outlined),
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
                      width: 300,
                      child: TextField(
                        controller: controllers.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: LanguageItems.passwordTitle,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.password_outlined),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 6)),
                    SizedBox(
                        height: 58,
                        width: 300,
                        child: CustomDropdownButton2(
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hint: selectedValue ?? 'Role',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(600, 50)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black12),
                      ),
                      onPressed: () async {
                        if (controllers.firstNameController.text.isNotEmpty &&
                            controllers.lastNameController.text.isNotEmpty &&
                            controllers.emailController.text.isNotEmpty &&
                            controllers.phoneController.text.isNotEmpty &&
                            controllers.passwordController.text.isNotEmpty &&
                            selectedValue != null) {
                          bool? confirmed =
                              await _confirmedAddShowDialog(context);
                          if (confirmed == true) {
                            AuthRegisterModel newUser = _newUser();
                            await register(newUser);
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
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmedAddShowDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        var dialogHeaderBlackAndColorText =
            controllers.firstNameController.text ?? 'Add';
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

  AuthRegisterModel _newUser() {
    AuthRegisterModel newUser = AuthRegisterModel(
      firstname: controllers.firstNameController.text,
      lastname: controllers.lastNameController.text,
      email: controllers.emailController.text,
      phone: controllers.phoneController.text,
      password: controllers.passwordController.text,
      role: selectedValue,
    );
    return newUser;
  }

  void navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ListViewHome();
        },
      ),
    );
  }
}

class UserTextEditingControllers {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  TextEditingController get firstNameController => _firstName;
  TextEditingController get lastNameController => _lastName;
  TextEditingController get emailController => _email;
  TextEditingController get phoneController => _phone;
  TextEditingController get passwordController => _password;
}
