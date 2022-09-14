import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:note_sharing_project/models/user_model.dart';

import '../utils/custom_exception.dart';

class ApiService {
  // final _dio = Dio();
  final Dio _dio = Dio();

  ApiService() {
    _dio.interceptors.add(ChuckerDioInterceptor());
  }

  static const String _baseUrl = "https://note-sharing-project.herokuapp.com/";
  static const String _getUsers =
      "https://note-sharing-project.herokuapp.com/users";
  static const String _postUsers =
      "https://note-sharing-project.herokuapp.com/users";

  Future<UserModel?> getUsers({required String id}) async {
    try {
      final response = await _dio.get("$_getUsers/$id");
      final jsonResult = Map<String, dynamic>.from(response.data);
      return UserModel.fromMap(jsonResult);
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).message;
    } on SocketException {
      throw "No Internet Idiot";
    }
  }

  Future<String?> createUser({required UserModel user}) async {
    try {
      await _dio.post(
        _postUsers,
        data: user.toMap(),
      );
      return "Success";
    } on DioError catch (e) {
      return DioExceptions.fromDioError(e).message;
    } on SocketException {
      return "No Internet Idiot";
    }
  }
}
