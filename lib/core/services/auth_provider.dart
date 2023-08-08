import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:self_park/core/models/Auth/AuthRegisterModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Auth/AuthModel.dart';

abstract class IAuthProvider {
  Future<void> authenticate(String email, String password);
  Future<void> loadTokenFromPrefs();
  Future<void> logout();
  Future<bool> registerUser(AuthRegisterModel newUser, context);
}

class AuthProvider with ChangeNotifier implements IAuthProvider {
  String? _token;
  String? _role;
  final Dio _networkManager;

  AuthProvider()
      : _networkManager =
            Dio(BaseOptions(baseUrl: 'http://192.168.4.190:8080/api/v1/auth/'));

  String? get token => _token;
  String? get role => _role;

  bool get isAuthenticate => _token != null;

  @override
  Future<void> authenticate(String email, String password) async {
    try {
      final response = await _networkManager.post(AuthPath.authenticate.name,
          data: AuthPostModel(email: email, password: password).toJson());

      if (response.statusCode == 200) {
        _token = response.data['token'];
        print("token : $_token");

        _role = response.data['user']['role'];

        // save token and role to shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('role', _role!);

        notifyListeners();
      } else {
        print('Failed token: Status Code: ${response.statusCode}');
        throw Exception('Error token');
      }
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
      throw Exception('Error getting token');
    }
  }

  @override
  Future<void> loadTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _role = prefs.getString('role');
    notifyListeners();
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    _token = null;
    _role = null;
    notifyListeners();
  }

  @override
  Future<bool> registerUser(AuthRegisterModel newUser, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final role = authProvider.role;
      print(token);
      print(role);

      final response = await _networkManager.post(
        AuthPath.register.name,
        data: newUser.toJson(),
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) ;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return false;
  }
}

enum AuthPath { register, authenticate, isTokenExpired }

class ShowDebug {
  static void showDioError<T>(DioException error, T type) async {
    if (kDebugMode) {
      print('error message auth provider: ${error.message}');
      print('---');
      print('type auth provider: $type');
    }
  }
}
