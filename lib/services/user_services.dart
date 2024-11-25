import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_laravel_blog/constant.dart';
import 'package:flutter_laravel_blog/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_laravel_blog/models/user.dart';

// LOGIN

Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(
          jsonDecode(response.body),
        );
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elemenAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Register
Future<ApiResponse> register(String name,String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(
          jsonDecode(response.body),
        );
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elemenAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// User

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse(userURL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );

      switch(response.statusCode){
        case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
        case 401:
        apiResponse.error = unauthorized;
        break;
        default:
        apiResponse.error = somethingWentWrong;
        break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
}


// get token
Future getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
}

// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

// logout
Future<bool> logut() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('token');
}