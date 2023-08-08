import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/Park/ParkInfoGetModel.dart';
import 'auth_provider.dart';

abstract class IParkPostService {
  Future<List<ParkInfoGetAllModel>?> fetchPostItems(context);
  Future<List<ParkInfoGetAllModel>?> relatedToFetchPostItems(int id, context);
  Future<bool> addNewItemToParkService(ParkInfoGetAllModel newPost, context);
  Future<bool> putItemToService(ParkInfoGetAllModel updatedModel, context);
  Future<bool> deleteItemToParkService(int id, context);
}

class ParkPostService implements IParkPostService {
  final Dio _networkManager;

  ParkPostService()
      : _networkManager = Dio(
            BaseOptions(baseUrl: 'http://192.168.4.190:8080/api/v1/parkInfo/'));

  // Park bilgileri listele
  @override
  Future<List<ParkInfoGetAllModel>?> fetchPostItems(context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.get(
        _ParkPostServicePaths.getAll.name,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => ParkInfoGetAllModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return null;
  }

  // Park ekle
  @override
  Future<bool> addNewItemToParkService(
      ParkInfoGetAllModel newPost, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.put(_ParkPostServicePaths.add.name,
          data: newPost.toJson(),
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          ));
      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }

    return false;
  }

// Park bilgilerini güncelle
  @override
  Future<bool> putItemToService(
      ParkInfoGetAllModel updatedModel, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.put(
        _ParkPostServicePaths.update.name,
        data: updatedModel.toJson(),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return false;
  }

  // Park bilgilerini sil
  @override
  Future<bool> deleteItemToParkService(int id, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      final response = await _networkManager.delete(
        _ParkPostServicePaths.delete.name,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {_PostQueryPaths.id.name: id},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return false;
  }

  @override
  Future<List<ParkInfoGetAllModel>?> relatedToFetchPostItems(
      int id, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.get(
        _ParkPostServicePaths.getParkById.name,
        queryParameters: {_PostQueryPaths.id.name: id},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => ParkInfoGetAllModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return null;
  }
}

enum _ParkPostServicePaths { getAll, update, getParkById, add, delete }

enum _PostQueryPaths { id }

class ShowDebug {
  static void showDioError<T>(DioException error, T type) async {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('---');
    }
  }
}
