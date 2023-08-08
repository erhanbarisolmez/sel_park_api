// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';

// import '../models/Park/ParkInfoGetModel.dart';

// class SocketService {
//   void main() {
//     _stompClient?.activate();
//   }
//   // _stompClient?.send(destination: '/', body: 'Your message body', headers: {});

//   StompClient? _stompClient;
//   final String stompUrl = 'http://192.168.4.190:8080/ws';

//   final String token;
//   bool _isConnected = false;

//   SocketService(this.token);

//   bool get isConnected => _isConnected;

//   Future<void> connect() async {
//     final stompConfig = StompConfig(
//       url: stompUrl,
//       onConnect: (StompFrame frame) {
//         print('socket connect');
//         subscribeToSocketChannel();
//         _isConnected = true;
//       },
//       onWebSocketError: (dynamic error) {
//         _isConnected = false;
//         print('socket connection error: $error');
//       },
//       stompConnectHeaders: {'Authorization': 'Bearer $token'},
//       webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
//     );
//     _stompClient = StompClient(config: stompConfig);
//     try {
//       await _stompClient!.activate;
//       var isConnected = _stompClient?.connected;
//       print('Socket connection established');
//       print(isConnected);
//     } catch (e) {
//       print('Socket connection error: $e');
//       _isConnected = false;
//     }

//     var isConnected = _stompClient!.connected;
//     print('Socket connection established');
//     print(isConnected);
//   }

//   Future<void> disconnect() async {
//     _stompClient?.deactivate();
//   }

//   void subscribeToSocketChannel() {
//     _stompClient?.subscribe(
//       destination: '/topic/parkInfo', // Socket üzerindeki hedef kanal
//       callback: (StompFrame frame) async {
//         print('Received socket notification: ${frame.body}');
//         // API'den güncellenmiş park listesini almak için ilgili fonksiyonu çağırabilirsiniz
//         await fetchPostItems();
//         // Alınan güncellenmiş park listesini kullanmak için gerekli işlemleri yapabilirsiniz
//       },
//     );
//   }

//   void sendNotification(String message) {
//     _stompClient?.send(
//       destination: '/topic/parkInfo',
//       body: message,
//     );
//     print(message);
//   }

//   Future<List<ParkInfoGetAllModel>> fetchPostItems() async {
//     final dio = Dio();
//     var _items;
//     var _searchList;
//     try {
//       var response = await dio.get(
//         'http://192.168.4.190:8080/api/v1/parkInfo/getAll',
//         options: Options(headers: {
//           'Authorization': 'Bearer $token',
//         }),
//       );
//       // print(response.statusCode);
//       // print(response.data);

//       if (response.statusCode == 200) {
//         final _datas = response.data;

//         if (_datas is List) {
//           _items = _datas.map((e) => ParkInfoGetAllModel.fromJson(e)).toList();
//           _searchList = _items;
//         }
//       }
//     } catch (e) {
//       print('Error post items : $e');
//     }

//     return _searchList != null ? _searchList! : [];
//   }
// }

//   // Future<List<ParkInfoGetAllModel>> getParkListFromAPI() async {
//   //   final dio = Dio();
//   //   final token = await getToken();
//   //   dio.options.headers['Authorization'] = 'Bearer $token';

//   //   try {
//   //     final response = await dio.get(
//   //       'http://192.168.4.190:8080/api/v1/parkInfo/getAll',
//   //       options: Options(
//   //         headers: {"Authorization": token},
//   //       ),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final List<dynamic> jsonList = response.data;

//   //       // API'den alınan verileri ParkInfoGetAllModel listesine dönüştür
//   //       final parkList =
//   //           jsonList.map((json) => ParkInfoGetAllModel.fromJson(json)).toList();
//   //       return parkList;
//   //     } else {
//   //       print('Failed to get park list. Status code: ${response.statusCode}');
//   //       return [];
//   //     }
//   //   } catch (e) {
//   //     print('Error occurred while getting park list: $e');
//   //     return [];
//   //   }
//   // }