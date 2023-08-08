// import 'package:dio/dio.dart';

// import '../models/Auth/AuthModel.dart';

// class TokenService {
//   final _baseUrl = 'http://192.168.4.190:8080/api/v1/';

//   // TOKEN AL
//   String? _token;
//   Future<String> getToken() async {
//     if (_token != null) {
//       return _token!;
//     } else {
//       final dio = Dio();
//       const email = 'admin@admin.com';
//       const password = 'passwrd';
//       // user :user@admin.com   şifre aynı.
//       try {
//         final response = await dio.post('${_baseUrl}auth/authenticate',
//             data: AuthPostModel(email: email, password: password).toJson());
//         if (response.statusCode == 200) {
//           _token = response.data['token'];
//           print(response);
//           print(_token);
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
