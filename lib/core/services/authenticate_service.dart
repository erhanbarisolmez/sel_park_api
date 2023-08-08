// import 'package:dio/dio.dart';
// import 'package:self_park/core/services/token_service.dart';

// import '../models/Auth/AuthModel.dart';

// abstract class IAuthService {
//   Future<String> authenticate(role, email, password);
// }

// class AuthService implements IAuthService {
//   final Dio _networkManager;

//   AuthService()
//       : _networkManager =
//             Dio(BaseOptions(baseUrl: 'http://192.168.4.190:8080/api/v1/auth'));

//   @override
//   Future<String> authenticate(role, email, password) async {
//     final token = await TokenService().getToken();
//     String? _token;
//     String? _role;
//     var email;
//     var password;
//     if (_token != null) {
//       return _token!;
//     } else {
//       try {
//         final response = await _networkManager.post(AuthPath.authenticate.name,
//             data: AuthPostModel(email: email, password: password).toJson());
//         if (response.statusCode == 200) {
//           _token = response.data['token'];

//           _role = response.data['role'];
//           role = _role;
//           print(_token);
//           print(_role);
//           print(response);
//           return _token!;
//         } else {
//           print('Failed token: Status code:  ${response.statusCode}');
//           throw Exception('Error token');
//         }
//       } catch (e) {
//         print('#Error. Token: $e');
//         throw Exception('Error getting token');
//       }
//     }
//   }
// }

// enum AuthPath { register, authenticate, isTokenExpired }
