/**
 * Copyright (C) 2021
 *
 * Description: The file class
 *
 * Change history:
 * Date             Defect#             Person             Comments
 * -------------------------------------------------------------------------------
 * August 4, 2021     ********           HoangNCM            Initialize
 *
 */

import 'dart:convert';

import 'package:gmc_erp/models/User.dart';
import 'package:gmc_erp/common/constants/Constants.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  http.Client httpClient = http.Client();

  Future<User> login(String username, String password) async {
    final url = "${Constants.apiBaseURL}/Users/login";
    print(jsonEncode({'usemame': username, 'password': password}));
    final response = await httpClient.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
