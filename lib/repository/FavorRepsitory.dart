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

import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/common/constants/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavorRepsitory {
  http.Client httpClient = http.Client();

  Future<List<Favor>> getFavor() async {
    final url = "${Constants.apiBaseURL}/favor";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')!}'
      },
    );

    if (response.statusCode == 200) {
      final respondData = json.decode(response.body) as List;
      final List<Favor> listResult = respondData.map((comment) {
        return Favor.fromJsonMap(comment);
      }).toList();

      return listResult;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get');
    }
  }

  Future<Favor> postFavor(String moduleName) async {
    final url = "${Constants.apiBaseURL}/favor";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')!}',
      },
      body: jsonEncode(<String, String>{
        'moduleName': moduleName,
      }),
    );

    if (response.statusCode == 200) {
      return Favor.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get');
    }
  }

  Future<int> deleteFavor(int id) async {
    final url = "${Constants.apiBaseURL}/favor/${id}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')!}',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load delete');
    }
  }
}
