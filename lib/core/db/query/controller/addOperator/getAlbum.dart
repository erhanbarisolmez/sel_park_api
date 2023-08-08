import 'dart:convert';

import 'package:http/http.dart' as http;

import 'album.dart';

Future<List<Album>> getAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  print(response);
  if (response.statusCode == 200) {
    // return Album.fromJson(jsonDecode(response.body));
    return (jsonDecode(response.body) as List).map((sendData) {
      return Album.fromJson(sendData);
    }).toList();
  } else {
    throw Exception('data error');
  }
}
