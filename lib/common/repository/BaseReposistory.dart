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

import 'package:http/http.dart' as http;

class BaseReposistory<TDto, TId> {

  Future<List<TDto>> getALl() async {
    final url =
        "https://jsonplaceholder.typicode.com/comments?_start=1&_limit=20";
    final http.Client httpClient = http.Client();
    try {
      final response = await httpClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responData = json.decode(response.body) as List;
        final List<TDto> listComment = [];

        return listComment;
      }
    } catch (exception) {}

    return [];
  }
}