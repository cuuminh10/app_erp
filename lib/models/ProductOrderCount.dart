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


class ProductOrderCount {

  int incompleted;
  int completed;
  int opens;
  int overdue;

  ProductOrderCount.fromJsonMap(Map<String, dynamic> map):
        incompleted = map["incompleted"],
        completed = map["completed"],
        opens = map["opens"],
        overdue = map["overdue"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incompleted'] = incompleted;
    data['completed'] = completed;
    data['opens'] = opens;
    data['overdue'] = overdue;
    return data;
  }
}