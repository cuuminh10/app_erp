// /**
//  * Copyright (C) 2021
//  *
//  * Description: The file class
//  *
//  * Change history:
//  * Date             Defect#             Person             Comments
//  * -------------------------------------------------------------------------------
//  * August 4, 2021     ********           HoangNCM            Initialize
//  *
//  */
//
//
// class Comments {
//
//   int id;
//   String avatarUrl;
//   String comment;
//   String createUser;
//   String createDate;
//
//   Comments.fromJsonMap(Map<String, dynamic> map):
//         id = map["id"],
//         avatarUrl = map["avatarUrl"],
//         comment = map["comment"],
//         createUser = map["createUser"],
//         createDate = map["createDate"];
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = id;
//     data['avatarUrl'] = avatarUrl;
//     data['createUser'] = createUser;
//     data['createUser'] = createUser;
//     data['createDate'] = createDate;
//     return data;
//   }
// }