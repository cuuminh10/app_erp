
import 'dart:core';

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


class ProductOrderDetail {

  int id;
  String no;
  String name;
  String description;
  String ordDate;
  String employeeName;
  String woNo;
  List<Detail>? listDetail;
  List<Attach>? listAttach;
  List<Comment>? listComment;

  ProductOrderDetail.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        no = map["no"],
        name = map["name"],
        description = map["description"],
        ordDate = map["ordDate"],
        employeeName = map["employeeName"],
        woNo = map["woNo"],
        listDetail = List<Detail>.from(
            map["detail"].map((x) => Detail.fromJsonMap(x))),
        listAttach = List<Attach>.from(
            map["attach"].map((x) => Attach.fromJsonMap(x))),
        listComment = List<Comment>.from(
            map["comment"].map((x) => Comment.fromJsonMap(x)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['no'] = no;
    data['name'] = name;
    data['description'] = description;
    data['ordDate'] = ordDate;
    data['employeeName'] = employeeName;
    data['woNo'] = woNo;
    data['detail'] = listDetail;
    data['attach'] = listAttach;
    data['comment'] = listComment;
    return data;
  }

}

class Detail {
  int itemID;
  double qty;
  String remark;
  String productNo;
  String phaseName;
  String unit;

  Detail.fromJsonMap(Map<String, dynamic> map):
        itemID = map["itemID"],
        qty = map["qty"],
        remark = map["remark"],
        productNo = map["productNo"],
        phaseName = map["phaseName"],
        unit = map["unit"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemID'] = itemID;
    data['qty'] = qty;
    data['remark'] = remark;
    data['productNo'] = productNo;
    data['phaseName'] = phaseName;
    data['unit'] = unit;
    return data;
  }

}

class Attach {
  int id;
  String realName;
  String saveName;
  String createUser;
  String createDate;

  Attach.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        realName = map["realName"],
        saveName = map["saveName"],
        createUser = map["createUser"],
        createDate = map["createDate"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['realName'] = realName;
    data['saveName'] = saveName;
    data['createUser'] = createUser;
    data['createDate'] = createDate;
    return data;
  }

}

class Comment {
  int id;
  String comment;
  String avatarUrl;
  String createUser;
  String createDate;

  Comment.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        comment = map["comment"],
        createUser = map["createUser"],
        createDate = map["createDate"],
        avatarUrl = map["avatarUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['comment'] = comment;
    data['createUser'] = createUser;
    data['createDate'] = createDate;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}