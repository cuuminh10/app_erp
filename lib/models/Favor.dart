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


class Favor {

  int id;
  String moduleName;
  String? image;
  String? name;

  Favor(this.id, this.moduleName, this.image, this.name);

  Favor.fromJsonMap(Map<String, dynamic> map):
        id = map["id"],
        moduleName = map["moduleName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['moduleName'] = moduleName;
    return data;
  }
}