
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
  String jobTicketNo;
  List<Detail> listDetail;
  List<Attach> listAttach;
  List<Comment> listComment;

  ProductOrderDetail.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        no = map["no"],
        name = map["name"],
        description = map["description"],
        ordDate = map["ordDate"],
        employeeName = map["employeeName"] ?? '',
        woNo = map["woNo"]  ?? '',
        jobTicketNo = map["jobTicketNo"]  ?? '',
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
    data['jobTicketNo'] = jobTicketNo;
    return data;
  }

}

class Detail {
  int itemID;
  String remark;
  String productNo;
  String phaseName;
  String unit;
  double qty;
  double cancelQty;
  double setUpQty;
  double ncrQty;

  Detail.fromJsonMap(Map<String, dynamic> map):
        itemID = map["itemID"],
        qty = map["qty"],
        remark = map["remark"],
        productNo = map["productNo"],
        phaseName = map["phaseName"],
        unit = map["unit"],
        cancelQty = double?.parse("0" ?? map["cancelQty"].toString() ),
        setUpQty = double?.parse("0" ?? map["setUpQty"].toString()),
        ncrQty = double?.parse("0" ?? map["ncrQty"].toString());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemID'] = itemID;
    data['qty'] = qty;
    data['remark'] = remark;
    data['productNo'] = productNo;
    data['phaseName'] = phaseName;
    data['unit'] = unit;
    data['cancelQty'] = cancelQty;
    data['setUpQty'] = setUpQty;
    data['ncrQty'] = ncrQty;
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