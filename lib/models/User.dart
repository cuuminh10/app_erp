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


class User {

  int id;
  int groupId;
  int contactId;
  String username;
  String token;

  User.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        groupId = map["groupId"],
        contactId = map["contactId"],
        username = map["username"],
        token = map["token"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['groupId'] = groupId;
    data['contactId'] = contactId;
    data['username'] = username;
    data['token'] = token;
    return data;
  }
}