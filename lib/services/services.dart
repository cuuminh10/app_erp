import 'dart:convert';

import 'package:gmc_erp/models/Comment.dart';
import 'package:http/http.dart' as http;

Future<List<Comment>?> getCommentFromApi() async {
  final url =
      "https://jsonplaceholder.typicode.com/comments?_start=1&_limit=20";
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responData = json.decode(response.body) as List;
      final List<Comment> listComment = responData.map((comment) {
        return Comment(
            comment['id'], comment['name'], comment['email'], comment['body']);
      }).toList();
      return listComment;
    }
  } catch (exception) {}

  return null;
}
