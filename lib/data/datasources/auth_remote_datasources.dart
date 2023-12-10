import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_app/core/constants/variables.dart';
import 'package:flutter_cbt_app/data/datasources/auth_local_datasources.dart';
import 'package:flutter_cbt_app/data/models/request/login_request_model.dart';
import 'package:flutter_cbt_app/data/models/request/register_request_model.dart';
import 'package:flutter_cbt_app/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {

  Future<Either<String, AuthResponseModel>> register(RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Register gagal');
    }
  }

  //Function for logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logout berhasil');
    } else {
      return const Left('Logout gagal');
    }
  }

  //Function for login
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel data) async {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        return const Left('Login gagal');
      }
    }
}

