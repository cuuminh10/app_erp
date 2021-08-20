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


class ProductOrderOpen {

  String no;
  String phaseName;
  String productDate;

  ProductOrderOpen.fromJsonMap(Map<String, dynamic> map):
        no = map["no"],
        phaseName = map["phaseName"],
        productDate = map["productDate"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = no;
    data['phaseName'] = phaseName;
    data['productDate'] = productDate;
    return data;
  }
}