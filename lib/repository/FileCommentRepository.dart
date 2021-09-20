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


import 'package:gmc_erp/common/constants/Constants.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FileCommentRepository {
  http.Client httpClient = http.Client();

  Future<Comment> postComments(String type, String no, String content) async {
    final url = "${Constants.apiBaseURL}/fc/comment/${type}/${no}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
      body: jsonEncode({'content': content}),
    );

    if (response.statusCode == 200) {
      return Comment.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get');
    }
  }

  Future<Attach> postAttach(String type, int objectId,String file ) async {
    final url = "${Constants.apiBaseURL}/fc/fileUpload/${type}/${objectId}";
    var map = new Map<String, dynamic>();
    map['file'] = file;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = { "Authorization": 'Bearer ${prefs.getString('token')}'};

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file));
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return Attach.fromJsonMap(json.decode(responseString));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get');
    }
  }
}
