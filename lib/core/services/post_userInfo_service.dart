import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:self_park/core/models/User/UserInfoGetAll.dart';
import 'package:self_park/core/services/auth_provider.dart';

abstract class IUserPostService {
  Future<List<UserInfoGetAllModel>?> fetchPostUserService(context);
  Future<bool> deleteItemToUserService(int id, context);
  Future<bool> putUserToService(UserInfoGetAllModel updatedModel, context);
  Future<List<UserInfoGetAllModel>?> relatedToFetchPostUsers(int id, context);
  Future<bool> putPasswordUpdate(context, UserInfoGetAllModel updatedPassword);
}

class UserPostService implements IUserPostService {
  final Dio _networkManager;

  UserPostService()
      : _networkManager =
            Dio(BaseOptions(baseUrl: 'http://192.168.4.190:8080/api/v1/user/'));

  @override
  Future<List<UserInfoGetAllModel>?> fetchPostUserService(context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.get(
          _UserPostServicePaths.getAll.name,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => UserInfoGetAllModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return null;
  }

  @override
  Future<bool> deleteItemToUserService(int id, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response = await _networkManager.put(
        _UserPostServicePaths.delete.name,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': 'Bearer $token',
          },
        ),
        data: {_UserQueryPaths.id.name: id},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return false;
  }

  @override
  Future<bool> putUserToService(
      UserInfoGetAllModel updatedModel, context) async {
    try {
      final autProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = autProvider.token;

      final response = await _networkManager.put(
        _UserPostServicePaths.update.name,
        options: Options(
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': 'Bearer $token',
          },
        ),
        data: updatedModel.toJson(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return false;
  }

  @override
  Future<List<UserInfoGetAllModel>?> relatedToFetchPostUsers(
      int id, context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      final response =
          await _networkManager.get(_UserPostServicePaths.getById.name,
              options: Options(headers: {
                'Authhorization': 'Bearer $token',
              }),
              queryParameters: {_UserQueryPaths.id.name: id});
      if (response.statusCode == 200) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => UserInfoGetAllModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }
    return null;
  }

  @override
  Future<bool> putPasswordUpdate(
      context, UserInfoGetAllModel updatedPassword) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      final response = await _networkManager.put(
        _UserPostServicePaths.passwordUpdate.name,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
        data: updatedPassword.toJson(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      ShowDebug.showDioError(e, this);
    }

    return false;
  }
}

enum _UserPostServicePaths { update, passwordUpdate, getAll, delete, getById }

enum _UserQueryPaths { id }

class ShowDebug {
  static void showDioError<T>(DioException error, T type) async {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print('----');
    }
  }
}
