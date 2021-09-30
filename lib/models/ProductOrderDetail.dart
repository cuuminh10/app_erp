
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
  String phaseNo;
  String workCenterName;
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
        phaseNo = map["phaseNo"]  ?? '',
        workCenterName = map["workCenterName"]  ?? '',
        jobTicketNo = map["jobTicketNo"]  ?? '',
        listDetail = map["detail"] != null ? List<Detail>.from(
            map["detail"].map((x) => Detail.fromJsonMap(x))) : [],
        listAttach =  map["attach"] != null ? List<Attach>.from(
            map["attach"].map((x) => Attach.fromJsonMap(x))) : [],
        listComment =  map["document"] != null ? List<Comment>.from(
            map["document"].map((x) => Comment.fromJsonMap(x))) : [];

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
    data['phaseNo'] = phaseNo;
    data['workCenterName'] = workCenterName;
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
  String productName;
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
        productName = map["productName"],
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
    data['productName'] = productName;
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
  String realName;
  String saveName;
  String comment;
  String types;
  String createUser;
  String createDate;

  Comment({this.comment= "", this.types= "comment", this.saveName= "", this.createUser= "", this.createDate, this.realName = ""});

  Comment.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        comment = map["comment"],
        createUser = map["createUser"],
        createDate = map["createDate"],
        realName = map["realName"],
        saveName = map["saveName"],
        types = map["types"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['comment'] = comment;
    data['createUser'] = createUser;
    data['createDate'] = createDate;
    data['realName'] = realName;
    data['saveName'] = saveName;
    data['types'] = types;
    return data;
  }
}